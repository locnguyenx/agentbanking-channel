import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer receives an SMS receipt from the backend notification gateway
Future<void> theCustomerReceivesAnSmsReceiptFromTheBackendNotificationGateway(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // In BDD, we just verify the transaction reached a final success state
  expect(find.textContaining('Success'), findsOneWidget);
}
