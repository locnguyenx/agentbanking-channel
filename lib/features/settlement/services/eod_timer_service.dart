import 'package:flutter_riverpod/flutter_riverpod.dart';

enum EodStatus { open, warning, locked }

final eodTimerServiceProvider = StateNotifierProvider<EodTimerService, EodStatus>((ref) => EodTimerService());

class EodTimerService extends StateNotifier<EodStatus> {
  final DateTime? clockOverride;

  EodTimerService({this.clockOverride}) : super(EodStatus.open) {
    updateStatus();
  }

  DateTime get _now => clockOverride ?? DateTime.now();

  void updateStatus() {
    final now = _now;
    // BDD @US-CA-22 FR-CA-8.3: 23:59:59 MYT — all STP financial workflows disabled
    if (now.hour == 23 && now.minute == 59 && now.second >= 59) {
      state = EodStatus.locked;
    }
    // BDD @US-CA-22 FR-CA-8.2: 23:55 warning displayed to agent
    else if (now.hour == 23 && now.minute >= 55) {
      state = EodStatus.warning;
    } else {
      state = EodStatus.open;
    }
  }

  EodStatus getCurrentEodStatus() => state;

  DateTime get now => _now;
}
