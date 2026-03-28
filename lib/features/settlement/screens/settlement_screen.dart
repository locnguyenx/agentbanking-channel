import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/providers/settlement_provider.dart';
import 'package:agentbanking_channel/features/settlement/models/settlement_models.dart';
import 'package:intl/intl.dart';

class SettlementScreen extends ConsumerStatefulWidget {
  const SettlementScreen({super.key});

  @override
  ConsumerState<SettlementScreen> createState() => _SettlementScreenState();
}

class _SettlementScreenState extends ConsumerState<SettlementScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(settlementProvider.notifier).fetchSummary());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settlementProvider);
    final notifier = ref.read(settlementProvider.notifier);

    if (state.status == SettlementStatus.settled) {
      return Scaffold(
        appBar: AppBar(title: const Text('Settlement Complete')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const Text('Batch Closed Successfully', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Batch No: ${state.result?.batchNumber}'),
              Text('Ref: ${state.result?.reference}'),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text('Please print the EOD report for your records.', textAlign: TextAlign.center),
              ),
              const SizedBox(height: 48),
              ElevatedButton(onPressed: () => notifier.reset(), child: const Text('Return Home')),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('EOD Settlement')),
      body: state.status == SettlementStatus.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Terminal: ${state.summary?.terminalId}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Date: ${state.summary != null ? DateFormat('yyyy-MM-dd HH:mm').format(state.summary!.timestamp) : ''}'),
                  const Divider(height: 32),
                  const Text('Service Breakdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.summary?.services.length ?? 0,
                      itemBuilder: (context, index) {
                        final s = state.summary!.services[index];
                        return Card(
                          child: ListTile(
                            title: Text(s.serviceName),
                            subtitle: Text('Items: ${s.count}'),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('RM ${s.totalAmount}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                Text('Com: RM ${s.totalCommission}', style: const TextStyle(fontSize: 12, color: Colors.green)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        _buildSummaryRow('Net Volume:', 'RM ${state.summary?.netVolume}'),
                        _buildSummaryRow('Total Commission:', 'RM ${state.summary?.totalCommission}', color: Colors.green),
                        const SizedBox(height: 8),
                        _buildSummaryRow('Grand Total:', 'RM ${state.summary?.grandTotal}', isBold: true),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, foregroundColor: Colors.white),
                      onPressed: state.status == SettlementStatus.ready ? () => notifier.performSettlement() : null,
                      child: state.status == SettlementStatus.processing
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Perform Settlement Closure'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: color)),
        ],
      ),
    );
  }
}
