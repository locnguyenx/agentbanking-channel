import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class CashlessPaymentForm extends StatefulWidget {
  final Function(String method, Decimal amount) onSubmit;

  const CashlessPaymentForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _CashlessPaymentFormState createState() => _CashlessPaymentFormState();
}

class _CashlessPaymentFormState extends State<CashlessPaymentForm> {
  String _selectedMethod = 'QR_CODE';
  final _amountController = TextEditingController(text: '10.00');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Cashless Payment', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 16),
        const Text('Select Payment Method', style: TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedMethod,
          items: const [
            DropdownMenuItem(value: 'QR_CODE', child: Text('QR Code (Scan to Pay)')),
            DropdownMenuItem(value: 'DEBIT_CARD', child: Text('Debit Card (Terminal)')),
          ],
          onChanged: (val) => setState(() => _selectedMethod = val!),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
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
              final amount = Decimal.tryParse(_amountController.text) ?? Decimal.zero;
              widget.onSubmit(_selectedMethod, amount);
            },
            child: const Text('PROCEED'),
          ),
        ),
      ],
    );
  }
}
