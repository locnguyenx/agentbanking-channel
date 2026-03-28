import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

class BalanceInquiryScreen extends ConsumerWidget {
  const BalanceInquiryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Balance Inquiry')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (state.status == TransactionStatus.success) ...[
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text('Balance:', style: TextStyle(fontSize: 18)),
              const Text(
                'RM ****', // Masked per Design §5.1
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'No funds were deducted',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => /* print receipt logic */ {},
                child: const Text('Print Receipt'),
              ),
              TextButton(
                onPressed: () => ref.read(transactionProvider.notifier).reset(),
                child: const Text('Done'),
              ),
            ] else if (state.status == TransactionStatus.failed) ...[
              const Icon(Icons.error, color: Colors.red, size: 80),
              const SizedBox(height: 16),
              Text(state.error ?? 'Unknown Error'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => ref.read(transactionProvider.notifier).reset(),
                child: const Text('Back'),
              ),
            ] else ...[
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text('Status: ${state.status.name}...'),
            ],
          ],
        ),
      ),
    );
  }
}
