import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the POS terminal local clock reaches 23:59:59 MYT
Future<void> thePosTerminalLocalClockReaches235959Myt(WidgetTester tester) async {
  final clockTime = DateTime(2026, 3, 27, 23, 59, 59);
  await pumpBddApp(tester, eodClock: clockTime);
}
