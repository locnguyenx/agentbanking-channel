import 'package:flutter_test/flutter_test.dart';

/// Usage: the app shows "Float credited: RM 99.00 | MDR: RM 1.00"
Future<void> theAppShowsFloatCreditedRm9900MdrRm100(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('Float Credited: RM 99.00'), findsOneWidget);
  expect(find.textContaining('MDR Deducted: RM 1.00'), findsOneWidget);
}
