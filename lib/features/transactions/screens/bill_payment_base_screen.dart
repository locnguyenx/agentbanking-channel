import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

class BillPaymentBaseScreen extends ConsumerStatefulWidget {
  final String title;
  final String serviceCode;
  final String? fixedBillerCode;
  final String metadataLabel;
  final String metadataKey;
  final String? metadataRegex;

  const BillPaymentBaseScreen({
    super.key,
    required this.title,
    required this.serviceCode,
    this.fixedBillerCode,
    required this.metadataLabel,
    required this.metadataKey,
    this.metadataRegex,
  });

  @override
  ConsumerState<BillPaymentBaseScreen> createState() => _BillPaymentBaseScreenState();
}

class _BillPaymentBaseScreenState extends ConsumerState<BillPaymentBaseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _metadataController = TextEditingController();
  FundingSource _fundingSource = FundingSource.CASH;
  String? _selectedBillerCode;

  @override
  void initState() {
    super.initState();
    _selectedBillerCode = widget.fixedBillerCode;
  }

  @override
  Widget build(BuildContext context) {
    final trState = ref.watch(transactionProvider);
    final trNotifier = ref.read(transactionProvider.notifier);
    final float = ref.watch(floatProvider);

    if (trState.status == TransactionStatus.success) {
      return Scaffold(
        appBar: AppBar(title: Text('${widget.title} Receipt')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 24),
              Text('Success!', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              Text('Reference: ${trState.result?.referenceId}'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  trNotifier.reset();
                  Navigator.of(context).pop();
                },
                child: const Text('DONE'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Float Banner
              Card(
                color: Colors.blue.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your Float Balance:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('RM ${float.currentBalance}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Biller Selector (if not fixed)
              if (widget.fixedBillerCode == null) ...[
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Select Biller', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'TNB', child: Text('TNB (Tenaga Nasional)')),
                    DropdownMenuItem(value: 'SYABAS', child: Text('Air Selangor')),
                    DropdownMenuItem(value: 'TM', child: Text('Telekom Malaysia')),
                  ],
                  onChanged: (val) => setState(() => _selectedBillerCode = val),
                  validator: (val) => val == null ? 'Please select a biller' : null,
                ),
                const SizedBox(height: 16),
              ],

              // Metadata Input (Ref-1 / Account Number / Phone)
              TextFormField(
                controller: _metadataController,
                decoration: InputDecoration(
                  labelText: widget.metadataLabel,
                  border: const OutlineInputBorder(),
                  hintText: 'Enter ${widget.metadataLabel}',
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (widget.metadataRegex != null) {
                    return OpenApiValidators.regex(val, widget.metadataRegex!);
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Amount
              TextFormField(
                controller: _amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount (RM)',
                  border: OutlineInputBorder(),
                  prefixText: 'RM ',
                ),
                validator: (val) => OpenApiValidators.minMax(val, min: 0.1, max: 10000.0),
              ),
              const SizedBox(height: 24),

              // Funding Source Toggle
              const Text('Funding Method', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<FundingSource>(
                      key: const Key('funding_source_CASH'),
                      title: const Text('Cash'),
                      value: FundingSource.CASH,
                      groupValue: _fundingSource,
                      onChanged: (val) => setState(() => _fundingSource = val!),
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<FundingSource>(
                      key: const Key('funding_source_CARD_EMV'),
                      title: const Text('Card'),
                      value: FundingSource.CARD_EMV,
                      groupValue: _fundingSource,
                      onChanged: (val) => setState(() => _fundingSource = val!),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Action Button
              if (trState.status == TransactionStatus.idle || trState.status == TransactionStatus.failed) ...[
                if (trState.error != null) 
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Text(trState.error!, style: const TextStyle(color: Colors.red)),
                  ),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                  child: const Text('PROCEED'),
                ),
              ],

              // Transaction Lifecycle States
              if (trState.status == TransactionStatus.quoting)
                const Center(child: CircularProgressIndicator()),

              if (trState.status == TransactionStatus.waitingConsent) ...[
                const Divider(),
                Text('Fee: RM ${trState.quote!.fee}', style: const TextStyle(fontSize: 18)),
                Text('Total: RM ${trState.quote!.total}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => trNotifier.confirmConsent(),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Confirm'),
                ),
              ],

              if (trState.status == TransactionStatus.validatingService)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Validating biller details...'),
                  ],
                ),

              if (trState.status == TransactionStatus.waitingCard)
                const Column(
                  children: [
                    Icon(Icons.credit_card, size: 64, color: Colors.blue),
                    SizedBox(height: 16),
                    Text('Please insert customer card...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),

              if (trState.status == TransactionStatus.waitingPin)
                const Column(
                  children: [
                    Icon(Icons.dialpad, size: 64, color: Colors.blue),
                    SizedBox(height: 16),
                    Text('Customer entering PIN on PIN pad...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),

              if (trState.status == TransactionStatus.waitingMyKadScan)
                const Column(
                  children: [
                    Icon(Icons.contact_emergency, size: 64, color: Colors.orange),
                    SizedBox(height: 16),
                    Text('Large Cash AML: Please scan Customer MyKad...', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),

              if (trState.status == TransactionStatus.processing)
                const Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Processing... Please do not eject card'),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      ref.read(transactionProvider.notifier).startTransaction(
        Decimal.parse(_amountController.text),
        'AGENT-123', // Hardcoded for demo
        serviceCode: widget.serviceCode,
        fundingSource: _fundingSource,
        metadata: {
          widget.metadataKey: _metadataController.text,
          if (_selectedBillerCode != null) 'billerCode': _selectedBillerCode,
        },
      );
    }
  }
}
