import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';

class ComplianceBanner extends ConsumerWidget {
  const ComplianceBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(complianceProvider);
    final notifier = ref.read(complianceProvider.notifier);

    if (!status.isFrozen) {
      return Container();
    }

    return Container(
      width: double.infinity,
      color: Colors.red.shade900,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.warning, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TERMINAL FROZEN',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      status.reason ?? 'Compliance review required.',
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Simulating Remote Unlock... Please wait (3s)')),
              );
              notifier.simulateWebhookUnlock();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              foregroundColor: Colors.white,
            ),
            child: const Text('Simulate Webhook Unlock'),
          ),
        ],
      ),
    );
  }
}
