import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';
import './the_agent_selects_epf_and_the_customer_chooses_contribution_type_isaraanisuri.dart';

Future<void> theEpfAccountReferenceIsValidated(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  if (find.byKey(const Key('btn_bill_payment')).evaluate().isNotEmpty) {
    await theAgentSelectsEpfAndTheCustomerChoosesContributionTypeIsaraanisuri(tester);
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
    throw TestFailure('EPF Validation Failure. Status: ${bddContainer.read(transactionProvider).status}');
  }
  
  expect(find.textContaining('Total to Deduct'), findsOneWidget);
}
