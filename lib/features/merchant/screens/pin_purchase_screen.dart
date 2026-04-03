import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart';

class PinPurchaseScreen extends ConsumerWidget {
  const PinPurchaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(merchantProvider);

    if (state.status == MerchantStatus.success) {
      final res = state.result as PinPurchaseResponse;
      return Scaffold(
        appBar: AppBar(title: const Text('PIN Issued')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Voucher PIN:', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                color: Colors.grey.shade200,
                child: Text(
                  res.pinCode, // BDD S9.3: 16-digit PIN
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              const SizedBox(height: 48),
              ElevatedButton(onPressed: () => ref.read(merchantProvider.notifier).reset(), child: const Text('Close')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('PIN Purchase (Voucher)')),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text('Select Voucher Type: Celcom, Maxis, Digi, etc.'),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                // Simplified for demo
                ref.read(merchantProvider.notifier).state = state.copyWith(
                  status: MerchantStatus.success, 
                  result: PinPurchaseResponse(
                    pinCode: '1234-5678-9012-3456',
                    commissionEarned: Decimal.parse('0.50'),
                    receiptReference: 'PIN-999',
                  ),
                );
              }, 
              child: const Text('Simulate Purchase'),
            ),
          ],
        ),
      ),
    );
  }
}
