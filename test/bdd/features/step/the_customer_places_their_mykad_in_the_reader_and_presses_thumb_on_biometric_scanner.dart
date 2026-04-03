import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theCustomerPlacesTheirMykadInTheReaderAndPressesThumbOnBiometricScanner(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  await tester.pumpAndSettle();
  final withdrawBtn = find.byKey(const Key('btn_withdrawal'));
  if (withdrawBtn.evaluate().isNotEmpty) {
      await tester.tap(withdrawBtn);
      await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);
  
  // If we are ALREADY in waitingConsent, it means a previous step triggered the quote.
  // We can skip directly to confirmation.
  if (bddContainer.read(transactionProvider).status == TransactionStatus.waitingConsent) {
    debugPrint('BDD: MyKad Withdrawal ALREADY in waitingConsent phase, skipping form entry.');
  } else {
    // Poll for the form to appear
    bool found = false;
    for (int i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (find.byKey(const Key('field_amount')).evaluate().isNotEmpty) {
        found = true;
        break;
      }
    }
    
    if (!found) {
      throw TestFailure('MyKad Withdrawal Form Failure. Status: ${bddContainer.read(transactionProvider).status}');
    }

    // MyKad Biometric Withdrawal flow
    await tester.enterText(find.byKey(const Key('field_amount')), '100.00');
    await tester.pumpAndSettle();
    
    await tester.tap(find.byKey(const Key('btn_main_action')));
    await tester.pumpAndSettle();
  }
  
  // Handle AGREE
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
}
