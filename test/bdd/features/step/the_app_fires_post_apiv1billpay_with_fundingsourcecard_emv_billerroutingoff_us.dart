import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import '../../bdd_test_helper.dart';

Future<void>
    theAppFiresPostApiv1billpayWithFundingsourcecardEmvBillerroutingoffUs(
        WidgetTester tester) async {
  // Setup mock
  mockTransactionRepository.executeTransactionStub = (req, agentId, {idempotencyKey}) async {
    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'BT_CARD_OFFUS_456',
    );
  };

  final confirmBtn = find.byKey(const Key('btn_confirm'));
  // In some flows, it might already be at CONFIRM button
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
