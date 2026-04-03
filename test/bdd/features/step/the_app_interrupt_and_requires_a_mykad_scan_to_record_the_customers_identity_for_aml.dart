import 'package:flutter_test/flutter_test.dart';

Future<void> theAppInterruptsAndRequiresAMykadScanToRecordTheCustomersIdentityForAml(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Check for the AML state or message
  // In TransactionNotifier, this shows the compliance screen or alert
  expect(find.textContaining('compliance'), findsOneWidget);
}
