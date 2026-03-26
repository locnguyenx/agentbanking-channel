import 'package:flutter/material.dart';

class SpecialServicesForm extends StatefulWidget {
  final String serviceType; // 'ESSP' or 'PIN'
  final Function(Map<String, dynamic> metadata, double amount) onSubmit;

  const SpecialServicesForm({Key? key, required this.serviceType, required this.onSubmit}) : super(key: key);

  @override
  _SpecialServicesFormState createState() => _SpecialServicesFormState();
}

class _SpecialServicesFormState extends State<SpecialServicesForm> {
  final _idController = TextEditingController();
  final _amountController = TextEditingController(text: '50.00');

  @override
  Widget build(BuildContext context) {
    final title = widget.serviceType == 'ESSP' ? 'eSSP Purchase' : 'PIN Purchase';
    final label = widget.serviceType == 'ESSP' ? 'MyKad / Account Number' : 'Reference Number';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: _idController,
          decoration: InputDecoration(
            hintText: 'Enter details',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 24),
        const Text('Amount (RM)', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        TextField(
          controller: _amountController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            prefixText: 'RM ',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              widget.onSubmit({
                'identifier': _idController.text,
                'serviceSubtype': widget.serviceType,
              }, amount);
            },
            child: const Text('PURCHASE'),
          ),
        ),
      ],
    );
  }
}
