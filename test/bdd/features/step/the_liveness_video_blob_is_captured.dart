import 'package:flutter_test/flutter_test.dart';

Future<void> theLivenessVideoBlobIsCaptured(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  // Simulate liveness capture completion
  // In a real app, this might involve waiting for a camera stream.
  // Here we just ensure we are in the right state.
  expect(find.textContaining('Blink Twice'), findsNothing);
}
