import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

class BalanceInquiryResult extends StatefulWidget {
  final Decimal balance;
  final String referenceId;
  final VoidCallback onDone;

  const BalanceInquiryResult({
    Key? key,
    required this.balance,
    required this.referenceId,
    required this.onDone,
  }) : super(key: key);

  @override
  State<BalanceInquiryResult> createState() => _BalanceInquiryResultState();
}

class _BalanceInquiryResultState extends State<BalanceInquiryResult> {
  bool _isMasked = true;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(symbol: 'RM ', decimalDigits: 2);
    final displayedBalance = _isMasked ? 'RM ****.**' : formatter.format(widget.balance.toDouble());

    return Column(
      children: [
        const Icon(Icons.account_balance_wallet, color: Colors.indigo, size: 80),
        const SizedBox(height: 24),
        const Text(
          'Balance Inquiry Successful',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.indigo.shade100),
          ),
          child: Column(
            children: [
              const Text(
                'AVAILABLE BALANCE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                displayedBalance,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier', // For a classic banking receipt feel
                ),
              ),
              const SizedBox(height: 16),
              TextButton.icon(
                onPressed: () => setState(() => _isMasked = !_isMasked),
                icon: Icon(_isMasked ? Icons.visibility : Icons.visibility_off),
                label: Text(_isMasked ? 'Reveal Balance' : 'Hide Balance'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Ref: ${widget.referenceId}',
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: widget.onDone,
            child: const Text('DONE'),
          ),
        ),
      ],
    );
  }
}
