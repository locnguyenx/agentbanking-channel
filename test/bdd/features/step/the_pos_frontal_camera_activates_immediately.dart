import 'package:flutter_test/flutter_test.dart';

/// Usage: the POS frontal camera activates immediately
Future<void> thePosFrontalCameraActivatesImmediately(
    WidgetTester tester) async {
  // Logic: Check for camera preview or liveness instructions
  expect(find.textContaining('LIVENESS'), findsOneWidget);
  expect(find.textContaining('BLINK'), findsOneWidget);
}
