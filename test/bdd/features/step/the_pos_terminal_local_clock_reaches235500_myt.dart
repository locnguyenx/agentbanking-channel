import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the POS terminal local clock reaches 23:55:00 MYT
Future<void> thePosTerminalLocalClockReaches235500Myt(WidgetTester tester) async {
  final clockTime = DateTime(2026, 3, 27, 23, 55, 0);
  await pumpBddApp(tester, eodClock: clockTime);
}
