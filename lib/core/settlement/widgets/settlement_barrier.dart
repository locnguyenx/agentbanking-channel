import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/core/settlement/settlement_service.dart';

class SettlementBarrier extends ConsumerWidget {
  final Widget child;

  const SettlementBarrier({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(settlementStatusProvider);

    return Stack(
      children: [
        child,
        if (status == SettlementStatus.warning)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'SETTLEMENT APPROACHING: SYSTEM BLOCKS AT 23:59',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          ),
        if (status == SettlementStatus.blocked)
          Container(
            color: Colors.black.withValues(alpha: 0.85),
            child: Center(
              child: Card(
                margin: const EdgeInsets.all(32),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_clock, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      const Text(
                        'SYSTEM BLOCKED',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'EOD Settlement in progress. Please wait until 00:05 to resume operations.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
