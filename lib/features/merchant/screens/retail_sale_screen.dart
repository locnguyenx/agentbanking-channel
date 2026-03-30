import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

class RetailSaleScreen extends ConsumerStatefulWidget {
  const RetailSaleScreen({super.key});

  @override
  ConsumerState<RetailSaleScreen> createState() => _RetailSaleScreenState();
}

class _RetailSaleScreenState extends ConsumerState<RetailSaleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  FundingSource _fundingSource = FundingSource.CARD_EMV;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantProvider);
    final notifier = ref.read(merchantProvider.notifier);

    if (state.status == MerchantStatus.success) {
      final res = state.result as RetailSaleResponse;
      return Scaffold(
        appBar: AppBar(title: const Text('Sale Success')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              Text('Sale RM ${state.amount} Success', style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 16),
              Text('MDR Deducted: RM ${res.mdrAmount}', style: const TextStyle(color: Colors.red)),
              Text('Float Credited: RM ${res.floatCreditAmount}', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: () => notifier.reset(), child: const Text('New Sale')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Merchant Retail Sale')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: GlobalKey<FormState>(),
          child: Column(
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Sale Amount (RM)', prefixText: 'RM '),
                keyboardType: TextInputType.number,
                validator: (v) => OpenApiValidators.minMax(v, min: 0.1, max: 10000.0),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<FundingSource>(
                value: _fundingSource,
                items: const [
                  DropdownMenuItem(value: FundingSource.CARD_EMV, child: Text('Card (MDR 1%)')),
                  DropdownMenuItem(value: FundingSource.CASH, child: Text('Cash (No MDR)')),
                  DropdownMenuItem(value: FundingSource.DUITNOW_QR, child: Text('DuitNow QR (MDR 0.5%)')),
                ],
                onChanged: (val) => setState(() => _fundingSource = val!),
              ),
              const SizedBox(height: 32),
              
              if (state.status == MerchantStatus.idle)
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      if (Form.of(context).validate()) {
                        notifier.startRetailSale(Decimal.parse(_amountController.text), _fundingSource);
                      }
                    },
                    child: const Text('PROCEED'),
                  ),
                ),

            if (state.status == MerchantStatus.quoting)
              const CircularProgressIndicator(),

            if (state.status == MerchantStatus.displayingQr) ...[
              const Text('Scan to Pay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(key: Key('qr_code_display'), Icons.qr_code_2, size: 200, color: Colors.indigo), // Mock QR
              ),
              const SizedBox(height: 16),
              const Text('Waiting for customer payment...', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              const LinearProgressIndicator(),
            ],

            if (state.status == MerchantStatus.waitingCard) ...[
              Text('MDR Fee: RM ${state.mdr}', style: const TextStyle(fontSize: 18, color: Colors.orange)),
              const SizedBox(height: 16),
              const Icon(Icons.credit_card, size: 48),
              const Text('Please tap/insert card'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => notifier.processCardSale(), child: const Text('Simulate Card Insert')),
            ],

            if (state.status == MerchantStatus.waitingPin)
              const Text('Please Enter PIN on terminal...'),

            if (state.status == MerchantStatus.processing)
              const CircularProgressIndicator(),

            if (state.status == MerchantStatus.failed)
              Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    ),
    );
  }
}
