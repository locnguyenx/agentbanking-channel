import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class EWalletForm extends StatefulWidget {
  final Function(String type, String mobile, Decimal amount) onSubmit;

  const EWalletForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _EWalletFormState createState() => _EWalletFormState();
}

class _EWalletFormState extends State<EWalletForm> {
  String _type = 'TOPUP'; // TOPUP or WITHDRAWAL
  final _mobileController = TextEditingController();
  final _amountController = TextEditingController(text: '10.00');

  @override
  Widget build(BuildContext context) {
    return Column(
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
        TextField(
          controller: _mobileController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'e.g., 0123456789',
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
              final amount = Decimal.tryParse(_amountController.text) ?? Decimal.zero;
              widget.onSubmit(_type, _mobileController.text, amount);
            },
            child: Text(_type == 'TOPUP' ? 'TOP-UP NOW' : 'WITHDRAW NOW'),
          ),
        ),
      ],
    );
  }
}
