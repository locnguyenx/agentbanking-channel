import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the terminal is in the "Settlement in Progress" state
Future<void> theTerminalIsInTheSettlementInProgressState(WidgetTester tester) async {
  // Use a clock value that is exactly at cut-off (00:00:00 of next day)
  final cutOffTime = DateTime(2026, 3, 28, 0, 0, 0);
  await pumpBddApp(tester, eodClock: cutOffTime);
}
