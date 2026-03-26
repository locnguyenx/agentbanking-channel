import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/core/offline/widgets/offline_indicator.dart';

// Provider for the amount input
final transactionAmountProvider = StateProvider.autoDispose<String>((ref) => '100.00');

class TransactionFlowScreen extends ConsumerWidget {
  final String title;
  final String serviceCode;

  const TransactionFlowScreen({
    Key? key,
    required this.title,
    required this.serviceCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionProvider);
    final authState = ref.watch(authProvider);
    final agentId = authState.user?.agentId ?? 'AGENT_UNKNOWN';
    final amountText = ref.watch(transactionAmountProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: const [OfflineIndicator()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStateView(context, ref, state, agentId, amountText),
                    if (state.status == TransactionStatus.failed)
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Text(
                          state.error ?? 'Unknown Error', 
                          style: const TextStyle(color: Colors.red, fontSize: 13),
                          textAlign: TextAlign.center,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateView(BuildContext context, WidgetRef ref, TransactionState state, String agentId, String amountText) {
    switch (state.status) {
      case TransactionStatus.idle:
        final bool needsAmount = serviceCode != 'BAL_INQ';
        
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                needsAmount ? Icons.payments_outlined : Icons.account_balance_wallet_outlined,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            if (needsAmount) ...[
              const Text('Enter Amount', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const Text('Enter amount to continue', style: TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 32),
              TextField(
                onChanged: (value) => ref.read(transactionAmountProvider.notifier).state = value,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textAlign: TextAlign.center,
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: amountText,
                    selection: TextSelection.collapsed(offset: amountText.length),
                  ),
                ),
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  prefixText: 'RM ',
                  prefixStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 32),
            ] else 
              const Column(
                children: [
                  Text('Balance Inquiry', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Check customer account balance securely', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
                  SizedBox(height: 32),
                ],
              ),
              
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  final amount = needsAmount ? (double.tryParse(amountText) ?? 0.0) : 0.0;
                  if (needsAmount && amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid amount')));
                    return;
                  }
                  ref.read(transactionProvider.notifier).startTransaction(amount, agentId, serviceCode: serviceCode);
                },
                child: Text(needsAmount ? 'GET QUOTE' : 'PROCEED'),
              ),
            ),
          ],
        );
      case TransactionStatus.quoting:
      case TransactionStatus.processing:
        return Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(
              state.status == TransactionStatus.quoting ? 'Calculating Fees...' : 'Processing Transaction...',
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ],
        );
      case TransactionStatus.waitingConsent:
        return Column(
          children: [
            const Text('Confirm Details', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 24),
            if (serviceCode != 'BAL_INQ') ...[
              _buildSummaryRow('Amount', 'RM ${state.quote?.amount}'),
              const Divider(height: 24),
              _buildSummaryRow('Transaction Fee', 'RM ${state.quote?.fee}'),
              const Divider(height: 24),
              _buildSummaryRow('Total to Charged', 'RM ${state.quote?.total}', isBold: true),
            ] else 
              const Text('Secure balance check initiated.', style: TextStyle(fontSize: 14)),
              
            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => ref.read(transactionProvider.notifier).reset(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => ref.read(transactionProvider.notifier).confirmConsent(),
                    child: const Text('Confirm'),
                  ),
                ),
              ],
            ),
          ],
        );
      case TransactionStatus.waitingCard:
        return const Column(
          children: [
            Icon(Icons.credit_card_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Insert Customer Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Please use the attached card reader', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.waitingPin:
        return const Column(
          children: [
            Icon(Icons.pin_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 24),
            Text('Enter Secure PIN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Customer should enter PIN on the PinPad', style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        );
      case TransactionStatus.success:
        return Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            Text('Success!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green.shade700)),
            const SizedBox(height: 8),
            Text('${title.toUpperCase()} COMPLETED', style: const TextStyle(fontSize: 12, color: Colors.grey, letterSpacing: 1)),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  _buildSummaryRow('Reference ID', state.result?.referenceId ?? 'N/A', small: true),
                  const SizedBox(height: 8),
                  _buildSummaryRow('Status', 'APPROVED', color: Colors.green, small: true),
                ],
              ),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(transactionProvider.notifier).reset(),
                child: const Text('DONE'),
              ),
            ),
          ],
        );
      case TransactionStatus.failed:
        return Column(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 80),
            const SizedBox(height: 24),
            const Text('Transaction Failed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(transactionProvider.notifier).reset(),
                child: const Text('TRY AGAIN'),
              ),
            ),
          ],
        );
    }
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? color, bool small = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: small ? 11 : 14)),
        Text(
          value, 
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            fontSize: small ? 11 : (isBold ? 18 : 14),
            color: color,
          ),
        ),
      ],
    );
  }
}
