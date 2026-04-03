import 'package:flutter_test/flutter_test.dart';

Future<void> informsTheCustomerApplicationQueuedForAnalystReviewYouWillBeNotifiedViaSms(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('Manual Review Required'), findsOneWidget);
  expect(find.textContaining('Your application has been queued for analyst review'), findsOneWidget);
}
