import 'package:flutter_test/flutter_test.dart';

/// Usage: the customer approves on their smartphone
Future<void> theCustomerApprovesOnTheirSmartphone(WidgetTester tester) async {
  // MUST advance the polling timer manually for Future.delayed in TransactionNotifier
  await tester.pump(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}
