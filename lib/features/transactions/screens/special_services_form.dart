import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class SpecialServicesForm extends StatefulWidget {
  final String serviceType; // 'ESSP' or 'PIN'
  final Function(Map<String, dynamic> metadata, Decimal amount) onSubmit;

  const SpecialServicesForm({super.key, required this.serviceType, required this.onSubmit});

  @override
  _SpecialServicesFormState createState() => _SpecialServicesFormState();
}

class _SpecialServicesFormState extends State<SpecialServicesForm> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedProvider;
  String? _selectedDenomination;
  final _idController = TextEditingController();
  final _amountController = TextEditingController(text: '50.00');

  final List<String> _providers = ['Digi', 'Celcom', 'Maxis', 'U-Mobile'];
  final List<String> _denominations = ['RM 5', 'RM 10', 'RM 30', 'RM 50', 'RM 100'];

  @override
  Widget build(BuildContext context) {
    if (widget.serviceType == 'PIN') {
      return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('PIN Purchase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Provider', border: OutlineInputBorder()),
              items: _providers.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _selectedProvider = v),
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Select Denomination', border: OutlineInputBorder()),
              items: _denominations.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
              onChanged: (v) {
                setState(() {
                  _selectedDenomination = v;
                  if (v != null) {
                    _amountController.text = v.replaceAll('RM ', '');
                  }
                });
              },
              validator: (v) => v == null ? 'Required' : null,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              key: const Key('btn_main_action'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit({
                    'provider': _selectedProvider,
                    'denomination': _selectedDenomination,
                    'serviceSubtype': 'PIN',
                  }, Decimal.parse(_amountController.text));
                }
              },
              child: const Text('PURCHASE'),
            ),
          ],
        ),
      );
    }

    // Default ESSP/Other fallback
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Special Services', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        TextField(
          controller: _idController,
          decoration: const InputDecoration(labelText: 'Identifier', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _amountController,
          decoration: const InputDecoration(labelText: 'Amount', border: OutlineInputBorder()),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          key: const Key('btn_main_action'),
          onPressed: () {
            widget.onSubmit({
              'identifier': _idController.text,
              'serviceSubtype': widget.serviceType,
            }, Decimal.tryParse(_amountController.text) ?? Decimal.zero);
          },
          child: const Text('PURCHASE'),
        ),
      ],
    );
  }
}
