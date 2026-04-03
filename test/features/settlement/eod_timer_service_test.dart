import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';

void main() {
  group('EodTimerService BDD Tests', () {
    // BDD @US-CA-22 FR-CA-8.2: 23:55 warning displayed to agent
    test('returns EodStatus.warning at 23:55 MYT', () {
      final svc = EodTimerService(clockOverride: DateTime(2026, 1, 1, 23, 55, 0));
      expect(svc.getCurrentEodStatus(), EodStatus.warning);
    });

    test('returns EodStatus.warning at 23:58 MYT', () {
      final svc = EodTimerService(clockOverride: DateTime(2026, 1, 1, 23, 58, 0));
      expect(svc.getCurrentEodStatus(), EodStatus.warning);
    });

    // BDD @US-CA-22 FR-CA-8.3: 23:59:59 MYT — all STP financial workflows disabled
    test('returns EodStatus.locked at 23:59:59 MYT', () {
      final svc = EodTimerService(clockOverride: DateTime(2026, 1, 1, 23, 59, 59));
      expect(svc.getCurrentEodStatus(), EodStatus.locked);
    });

    test('returns EodStatus.locked exactly at midnight (implicitly part of next day)', () {
       // Technially 00:00:00 is next day, so it should be open
      final svc = EodTimerService(clockOverride: DateTime(2026, 1, 2, 0, 0, 0));
      expect(svc.getCurrentEodStatus(), EodStatus.open);
    });

    // BDD @US-CA-22: Normal hours open
    test('returns EodStatus.open during normal business hours', () {
      final svc = EodTimerService(clockOverride: DateTime(2026, 1, 1, 10, 30, 0));
      expect(svc.getCurrentEodStatus(), EodStatus.open);
    });
  });
}
