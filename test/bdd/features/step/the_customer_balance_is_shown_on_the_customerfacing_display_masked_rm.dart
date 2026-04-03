import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theCustomerBalanceIsShownOnTheCustomerfacingDisplayMaskedRm(
    WidgetTester tester) async {
  // Poll for the success state
  bool found = false;
  for (int i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.byKey(const Key('status_success')).evaluate().isNotEmpty) {
      found = true;
      break;
    }
  }
  
  if (!found) {
    throw TestFailure('Balance Inquiry Success Failure. Status: ${bddContainer.read(transactionProvider).status}');
  }
  
  // Support both "Successful" and "Success!"
  expect(find.byKey(const Key('status_success')), findsOneWidget);
  expect(find.textContaining('RM ****.**'), findsOneWidget);
}
