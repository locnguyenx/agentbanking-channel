import 'package:flutter_test/flutter_test.dart';

Future<void> theAppShowsApplicationQueuedForReviewABankOfficerWillContactYouShortly(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Expect the specific fail/manual-review text
  expect(find.textContaining('Bank Officer will contact you'), findsOneWidget);
}
