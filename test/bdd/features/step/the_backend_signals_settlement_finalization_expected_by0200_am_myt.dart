import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the backend signals settlement finalization (expected by 02:00 AM MYT)
Future<void> theBackendSignalsSettlementFinalizationExpectedBy0200AmMyt(WidgetTester tester) async {
  // Simulate the back-end "Unlock" signal by re-pumping the app with a post-settlement clock
  final postSettlementTime = DateTime(2026, 3, 28, 2, 0, 1);
  await pumpBddApp(tester, eodClock: postSettlementTime);
}
