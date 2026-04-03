import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../helpers/bdd_step_utils.dart';

Future<void> theAgentSelectsEpfAndTheCustomerChoosesContributionType(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final billPayBtn = find.byKey(const Key('btn_bill_payment'));
  if (find.byKey(const Key('btn_bill_payment')).evaluate().isNotEmpty) {
    expect(billPayBtn, findsOneWidget);
    await tester.tap(billPayBtn);
    await tester.pumpAndSettle();
  }

  await selectFundingSourceIfNeeded(tester);

  await tester.tap(find.text('Select Biller'));
  await tester.pumpAndSettle();
  await tester.tap(find.textContaining('EPF').last);
  await tester.pumpAndSettle();
}
