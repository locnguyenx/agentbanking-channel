import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SettlementStatus { open, warning, blocked }

final settlementProvider = StateNotifierProvider<SettlementNotifier, SettlementStatus>((ref) {
  return SettlementNotifier();
});

class SettlementNotifier extends StateNotifier<SettlementStatus> {
  Timer? _timer;

  SettlementNotifier() : super(SettlementStatus.open) {
    _startMonitor();
  }

  void _startMonitor() {
    _timer = Timer.periodic(const Duration(seconds: 30), (_) => _checkTime());
    _checkTime();
  }

  void _checkTime() {
    final now = DateTime.now(); // In production, force MYT timezone
    final hour = now.hour;
    final minute = now.minute;

    if (hour == 23 && minute >= 59) {
      if (state != SettlementStatus.blocked) state = SettlementStatus.blocked;
    } else if (hour == 23 && minute >= 55) {
      if (state != SettlementStatus.warning) state = SettlementStatus.warning;
    } else {
      if (state != SettlementStatus.open) state = SettlementStatus.open;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
