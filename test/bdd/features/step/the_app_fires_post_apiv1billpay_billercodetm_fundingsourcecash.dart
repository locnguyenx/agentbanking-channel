import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../../bdd_test_helper.dart';

Future<void> theAppFiresPostApiv1billpayBillercodetmFundingsourcecash(
    WidgetTester tester) async {
  mockTransactionRepository.executeTransactionStub = (req, agentId, {idempotencyKey}) async {
    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'TM_CASH_REF_123',
    );
  };

  final confirmBtn = find.byKey(const Key('btn_confirm'));
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }
  
  // Wait for success
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  await tester.pumpAndSettle();
}
