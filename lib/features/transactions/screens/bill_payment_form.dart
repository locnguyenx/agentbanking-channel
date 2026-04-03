import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

class BillPaymentForm extends StatefulWidget {
  final Function(String billerCode, String ref1, Decimal amount) onSubmit;

  const BillPaymentForm({super.key, required this.onSubmit});

  @override
  _BillPaymentFormState createState() => _BillPaymentFormState();
}

class _BillPaymentFormState extends State<BillPaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _billerController = TextEditingController();
  final _refController = TextEditingController();
  final _amountController = TextEditingController();

  final List<Map<String, String>> _billers = [
    {'name': 'JomPAY', 'code': 'JOMPAY'},
    {'name': 'Tenaga Nasional Berhad (TNB)', 'code': '5454'},
    {'name': 'Telekom Malaysia (TM)', 'code': '8888'},
    {'name': 'Astro RPN', 'code': 'ASTRO'},
    {'name': 'EPF', 'code': 'EPF'},
    {'name': 'Air Selangor', 'code': '1234'},
    {'name': 'Indah Water Konsortium', 'code': '5566'},
  ];

  String? _selectedBiller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedBiller,
              isExpanded: true,
              decoration: const InputDecoration(
                labelText: 'Select Biller',
                border: OutlineInputBorder(),
              ),
              items: _billers.map((biller) {
                return DropdownMenuItem<String>(
                  value: biller['code'],
                  child: Text('${biller['name']} (${biller['code']})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBiller = value;
                  _billerController.text = value ?? '';
                });
              },
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please select a biller';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _refController,
              decoration: const InputDecoration(
                labelText: 'Ref-1',
                border: OutlineInputBorder(),
              ),
              validator: (v) => OpenApiValidators.length(v, minLen: 5, maxLen: 20),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (v) => OpenApiValidators.minMax(v, min: 0.01),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              key: const Key('btn_main_action'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _billerController.text,
                    _refController.text,
                    Decimal.parse(_amountController.text),
                  );
                }
              },
              child: const Text('PROCEED'),
            ),
          ],
        ),
      ),
    );
  }
}
