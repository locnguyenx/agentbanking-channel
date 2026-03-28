import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';

class CashbackScreen extends ConsumerStatefulWidget {
  const CashbackScreen({super.key});

  @override
  ConsumerState<CashbackScreen> createState() => _CashbackScreenState();
}

class _CashbackScreenState extends ConsumerState<CashbackScreen> {
  final _saleController = TextEditingController();
  final _cashbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(merchantProvider);
    final notifier = ref.read(merchantProvider.notifier);

    if (state.status == MerchantStatus.success) {
      final res = state.result as CashbackResponse;
      return Scaffold(
        appBar: AppBar(title: const Text('Cashback Success')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              Text('Purchase: RM ${res.purchaseAmount}', style: const TextStyle(fontSize: 18)),
              Text('Cashback: RM ${res.cashBackAmount}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text('Total Charged: RM ${state.amount}', style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 32),
              ElevatedButton(onPressed: () => notifier.reset(), child: const Text('Done')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Cash-Back Hybrid')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _saleController,
              decoration: const InputDecoration(labelText: 'Sale Amount (RM)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _cashbackController,
              decoration: const InputDecoration(labelText: 'Additional Cash-Back (RM)'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),

            if (state.status == MerchantStatus.idle)
              ElevatedButton(
                onPressed: () => notifier.startCashback(
                  Decimal.parse(_saleController.text),
                  Decimal.parse(_cashbackController.text),
                ),
                child: const Text('Process Hybrid Sale'),
              ),

            if (state.status == MerchantStatus.waitingCard) ...[
              const Icon(Icons.credit_card, size: 48),
              const Text('Insert card for Hybrid transaction'),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => notifier.processCashbackHandshake(), child: const Text('Simulate Handshake')),
            ],

            if (state.status == MerchantStatus.processing)
              const CircularProgressIndicator(),

            if (state.status == MerchantStatus.failed)
              Text('Error: ${state.error}', style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
