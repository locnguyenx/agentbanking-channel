import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/dashboard/dashboard_screen.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentSelectsBalanceInquiryAndTheAppCallsPostApiv1balanceinquiry(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // 1. Find and tap the circular Inquiry button on Dashboard
  final balanceBtn = find.byKey(const Key('btn_inquiry'));
  expect(balanceBtn, findsOneWidget);
  await tester.tap(balanceBtn);
  await tester.pumpAndSettle();

  // 2. Set up mock return for balance inquiry (Note: this calls legacy balanceInquiry method)
  mockTransactionRepository.balanceInquiryStub = (req, agentId) async {
    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'BAL_INQ_REF_123',
      balance: Decimal.parse('1500.50'),
      currency: 'MYR',
    );
  };

  // 3. Balance Inquiry has no input fields, just tap PROCEED (btn_main_action)
  // This triggers _executeTransaction which then calls repository.balanceInquiry
  final proceedBtn = find.byKey(const Key('btn_main_action'));
  if (proceedBtn.evaluate().isNotEmpty) {
      await tester.tap(proceedBtn);
      await tester.pumpAndSettle();
  }

  // 4. Handle AGREE if present (might be needed depending on implementation)
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
}
