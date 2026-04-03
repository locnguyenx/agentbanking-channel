import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/core/utils/openapi_validators.dart';

class TopUpForm extends StatefulWidget {
  final Function(String telco, String phoneNumber, Decimal amount) onSubmit;

  const TopUpForm({super.key, required this.onSubmit});

  @override
  _TopUpFormState createState() => _TopUpFormState();
}

class _TopUpFormState extends State<TopUpForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedTelco;
  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();

  final List<String> _telcos = ['CELCOM', 'DIGI', 'MAXIS', 'UMOBILE', 'M1'];

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
              decoration: const InputDecoration(labelText: 'Select Provider'),
              validator: (v) => v == null ? 'Please select a Telco' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                if (!ValidationService.isValidPhoneNumber(v)) return 'Invalid Phone Number';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Required';
                final err = OpenApiValidators.minMax(v, min: 1.0, max: 1000.0);
                return err != null ? 'Invalid Amount' : null;
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(
                    _selectedTelco!,
                    _phoneController.text,
                    Decimal.parse(_amountController.text),
                  );
                }
              },
              key: const Key('btn_main_action'),
              child: const Text('PROCEED'),
            ),
          ],
        ),
      ),
    );
  }
}
