import 'package:flutter_test/flutter_test.dart';

Future<void> noBankOfficerIsRequiredAtAnyStep(WidgetTester tester) async {
  // This is a semantic check - if the workflow proceeds without locking for officer, it passes.
  // We just ensure no 'WAITING FOR OFFICER' text or similar is visible.
  await tester.pumpAndSettle();
  expect(find.textContaining('Waiting for Officer'), findsNothing);
  expect(find.textContaining('OFFICER APPROVAL'), findsNothing);
}
