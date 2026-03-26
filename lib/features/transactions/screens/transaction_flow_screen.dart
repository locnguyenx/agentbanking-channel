import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';

class TransactionFlowScreen extends ConsumerWidget {
  const TransactionFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('New Transaction')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildStateView(context, ref, state),
              if (state.status == TransactionStatus.failed)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(state.error ?? 'Unknown Error', style: const TextStyle(color: Colors.red)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStateView(BuildContext context, WidgetRef ref, TransactionState state) {
    switch (state.status) {
      case TransactionStatus.idle:
        return ElevatedButton(
          onPressed: () => ref.read(transactionProvider.notifier).startTransaction(100.00, 'AGENT1'),
          child: const Text('Start Cash Withdrawal (RM 100)'),
        );
      case TransactionStatus.quoting:
      case TransactionStatus.processing:
        return const CircularProgressIndicator();
      case TransactionStatus.waitingConsent:
        return Column(
          children: [
            Text('Amount: RM ${state.quote?.amount}'),
            Text('Fee: RM ${state.quote?.fee}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(transactionProvider.notifier).confirmConsent(),
              child: const Text('Confirm & Proceed'),
            ),
          ],
        );
      case TransactionStatus.waitingCard:
        return const Text('PLEASE INSERT CUSTOMER CARD');
      case TransactionStatus.waitingPin:
        return const Text('PLEASE ENTER PIN ON PINPAD');
      case TransactionStatus.success:
        return Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 64),
            const Text('TRANSACTION SUCCESSFUL'),
            Text('Ref: ${state.result?.referenceId}'),
            ElevatedButton(
              onPressed: () => ref.read(transactionProvider.notifier).reset(),
              child: const Text('Done'),
            ),
          ],
        );
      case TransactionStatus.failed:
        return ElevatedButton(
          onPressed: () => ref.read(transactionProvider.notifier).reset(),
          child: const Text('Try Again'),
        );
    }
  }
}

// We need a provider definition somewhere
final transactionProvider = StateNotifierProvider<TransactionNotifier, TransactionState>((ref) {
  throw UnimplementedError('Initialize with correct dependencies in main.dart');
});
