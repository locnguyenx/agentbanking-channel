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

  // Select Funding Source: MyKad Biometric
  final mykadRadio = find.byKey(const Key('funding_source_MYKAD_BIOMETRIC'));
  if (mykadRadio.evaluate().isNotEmpty) {
    await tester.tap(mykadRadio);
    await tester.pumpAndSettle();
  }

  // Enter amount
  await tester.enterText(find.byKey(const Key('field_amount')), '100.00');
  await tester.pumpAndSettle();
  
  // Enter NRIC (metadata)
  await tester.enterText(find.byKey(const Key('nric')), '850101-01-5678');
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
  
  // Handle AGREE / Confirm Consent
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      // Don't pumpAndSettle yet, we want to see the "Waiting for MyKad" state
      await tester.pump(); 
  }

  // Verify that it went into waitingMyKadScan state
  expect(find.textContaining('Please Scan MyKad & Thumb'), findsOneWidget);
  
  // Let the mock finish
  await tester.pumpAndSettle();
}
