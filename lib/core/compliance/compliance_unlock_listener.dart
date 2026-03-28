import 'dart:async';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';

class ComplianceUnlockListener {
  final ComplianceNotifier compliance;
  final TransactionRepository repository;
  Timer? _timer;

  ComplianceUnlockListener({required this.compliance, required this.repository});

  /// Starts polling the backend for compliance status.
  /// BRD US-CA-21: Backend signal triggers auto-unlock without restart.
  void startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      if (!compliance.state.isFrozen) {
        timer.cancel();
        return;
      }

      try {
        final status = await repository.getComplianceStatus();
        if (status == 'UNLOCKED') {
          compliance.unlock();
          timer.cancel();
        }
      } catch (e) {
        // Silent fail, retry next cycle
      }
    });
  }

  void stop() {
    _timer?.cancel();
  }
}
