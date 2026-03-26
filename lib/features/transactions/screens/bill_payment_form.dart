import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';

class BillPaymentForm extends StatefulWidget {
  final Function(String billerCode, String ref1, double amount) onSubmit;

  const BillPaymentForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _BillPaymentFormState createState() => _BillPaymentFormState();
}

class _BillPaymentFormState extends State<BillPaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final _billerController = TextEditingController();
  final _refController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _billerController,
              decoration: const InputDecoration(labelText: 'Biller Code'),
              keyboardType: TextInputType.number,
              validator: (v) => ValidationService.isValidBillerCode(v ?? '') 
                  ? null : 'Invalid Biller Code',
            ),
            TextFormField(
              controller: _refController,
              decoration: const InputDecoration(labelText: 'Ref-1'),
              validator: (v) => ValidationService.isValidRef1(v ?? '') 
                  ? null : 'Invalid Ref-1',
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount (RM)'),
              keyboardType: TextInputType.number,
              validator: (v) {
                final amount = double.tryParse(v ?? '');
                return (amount != null && amount > 0) ? null : 'Invalid Amount';
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _billerController.text,
                    _refController.text,
                    double.parse(_amountController.text),
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
