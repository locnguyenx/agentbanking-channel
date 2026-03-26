import 'package:flutter/material.dart';

class ProxyEnquiryDialog extends StatelessWidget {
  final String maskedName;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ProxyEnquiryDialog({
    Key? key,
    required this.maskedName,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Verify Recipient'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Please confirm the recipient name:'),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              maskedName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onCancel,
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: const Text('CONFIRM'),
        ),
      ],
    );
  }
}
