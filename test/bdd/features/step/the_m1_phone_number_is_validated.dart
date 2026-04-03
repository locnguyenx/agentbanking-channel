import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';
import './the_agent_enters_the_customers_m1_phone_number_and_it_is_validated.dart';

Future<void> theM1PhoneNumberIsValidated(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // If we are still on Dashboard, it means the scenario skipped the entry step
  if (find.byKey(const Key('btn_top_up')).evaluate().isNotEmpty) {
    await theAgentEntersTheCustomersM1PhoneNumberAndItIsValidated(tester);
  }

  // Poll for the validation state
  bool found = false;
  for (int i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    if (find.textContaining('Total to Deduct').evaluate().isNotEmpty) {
      found = true;
      break;
    }
  }
  
  if (!found) {
    final status = bddContainer.read(transactionProvider).status;
    final error = bddContainer.read(transactionProvider).error;
    throw TestFailure('M1 Validation Failure. Status: $status, Error: $error');
  }
  
  expect(find.textContaining('Total to Deduct'), findsOneWidget);
}
