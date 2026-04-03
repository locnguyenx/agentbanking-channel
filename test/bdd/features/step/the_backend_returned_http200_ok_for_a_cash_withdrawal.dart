import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

/// Usage: the backend returned HTTP 200 OK for a Cash Withdrawal
Future<void> theBackendReturnedHttp200OkForACashWithdrawal(
    WidgetTester tester) async {
  if (find.byType(MaterialApp).evaluate().isEmpty) {
    await pumpBddApp(tester, isAuthenticated: true);
  }
  
  // Set up mock repository to return success
  mockTransactionRepository.executeTransactionStub = (req, agentId, {idempotencyKey}) async {
    return TransactionExecutionResponse(
      status: 'SUCCESS',
      referenceId: 'BDD_REF_123',
    );
  };

  // Navigate to Withdrawal screen
  final withdrawalButton = find.text('Withdrawal');
  expect(withdrawalButton, findsOneWidget);
  await tester.tap(withdrawalButton);
  await tester.pumpAndSettle();

  // Enter amount
  await tester.enterText(find.byType(TextField), '100');
  await tester.pumpAndSettle();

  // Get Quote
  await tester.tap(find.text('GET QUOTE'));
  await tester.pumpAndSettle();

  // Verify we are on confirmation screen
  bddContainer.read(transactionProvider).status;
  
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  if (confirmBtn.evaluate().isEmpty) {
     await tester.pumpAndSettle();
  }
  
  await tester.tap(find.byKey(const Key('btn_confirm')));
  
  // Wait for the confirmation handling (including the 500ms delay in confirmConsent)
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 200));
  }
  await tester.pumpAndSettle();
  
}
