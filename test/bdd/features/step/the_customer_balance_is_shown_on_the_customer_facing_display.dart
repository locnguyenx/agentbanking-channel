import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/widgets/balance_inquiry_result.dart';

/// Usage: the customer balance is shown on the customer-facing display
Future<void> theCustomerBalanceIsShownOnTheCustomerFacingDisplay(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // BalanceInquiryResult has its own unique success indicator or we can use the common one
  expect(find.byType(BalanceInquiryResult), findsOneWidget);
}
