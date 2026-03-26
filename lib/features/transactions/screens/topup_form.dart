import 'package:flutter/material.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';

class TopUpForm extends StatefulWidget {
  final Function(String telco, String phoneNumber, double amount) onSubmit;

  const TopUpForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _TopUpFormState createState() => _TopUpFormState();
}

class _TopUpFormState extends State<TopUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTelco;
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();

  final List<String> _telcos = ['CELCOM', 'DIGI', 'MAXIS', 'UMOBILE'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedTelco,
              items: _telcos.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
              onChanged: (v) => setState(() => _selectedTelco = v),
              decoration: const InputDecoration(labelText: 'Telco Provider'),
              validator: (v) => v == null ? 'Please select a Telco' : null,
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number (e.g. 012-3456789)'),
              keyboardType: TextInputType.phone,
              validator: (v) => ValidationService.isValidPhoneNumber(v ?? '') 
                  ? null : 'Invalid Phone Number',
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
                    _selectedTelco!,
                    _phoneController.text,
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
