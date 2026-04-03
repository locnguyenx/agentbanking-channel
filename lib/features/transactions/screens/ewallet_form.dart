import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

class EWalletForm extends StatefulWidget {
  final Function(String type, String mobile, Decimal amount) onSubmit;

  const EWalletForm({super.key, required this.onSubmit});

  @override
  _EWalletFormState createState() => _EWalletFormState();
}

class _EWalletFormState extends State<EWalletForm> {
  final _formKey = GlobalKey<FormState>();
  String _type = 'TOPUP'; // TOPUP or WITHDRAWAL
  final _mobileController = TextEditingController();
  final _amountController = TextEditingController(text: '10.00');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sarawak Pay e-Wallet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          const Text('Transaction Type', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('TOP-UP')),
                  selected: _type == 'TOPUP',
                  onSelected: (val) => setState(() => _type = 'TOPUP'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('WITHDRAW')),
                  selected: _type == 'WITHDRAWAL',
                  onSelected: (val) => setState(() => _type = 'WITHDRAWAL'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Mobile Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              labelText: 'Mobile Number', // Added label back for BDD lookup
              hintText: 'e.g., 0123456789',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
          ),
          const SizedBox(height: 24),
          const Text('Amount (RM)', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          TextFormField(
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: 'Amount', // Simplified for BDD compatibility
              prefixText: 'RM ',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            validator: (v) => OpenApiValidators.minMax(v, min: 1.0, max: 10000.0),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              key: const Key('btn_main_action'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final amount = Decimal.parse(_amountController.text);
                  widget.onSubmit(_type, _mobileController.text, amount);
                }
              },
              child: Text(_type == 'TOPUP' ? 'TOP-UP NOW' : 'WITHDRAW NOW'),
            ),
          ),
        ],
      ),
    );
  }
}
