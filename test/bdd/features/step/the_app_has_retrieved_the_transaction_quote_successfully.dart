import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart' as model;
import 'package:decimal/decimal.dart';
import '../../bdd_test_helper.dart';

Future<void> theAppHasRetrievedTheTransactionQuoteSuccessfully(WidgetTester tester) async {
  mockTransactionRepository.getQuoteStub = (req) async => model.TransactionQuoteResponse(
    amount: req.amount,
    fee: Decimal.fromInt(10),
    commission: Decimal.parse('0.50'),
    total: req.amount + Decimal.fromInt(10),
    quoteId: 'BDD_QUOTE_10',
  );
  await tester.pumpAndSettle();
  final withdrawalBtn = find.byKey(const Key('btn_withdrawal'));
  expect(withdrawalBtn, findsOneWidget);
  await tester.tap(withdrawalBtn);
  await tester.pumpAndSettle();

  final fields = find.byType(TextField);
  if (fields.evaluate().length > 1) {
    await tester.enterText(fields.at(0), '1234567890');
    await tester.enterText(fields.at(1), '100');
  } else {
    await tester.enterText(fields.at(0), '100');
  }
  await tester.pumpAndSettle();
  
  final quoteBtn = find.byKey(const Key('btn_main_action'));
  expect(quoteBtn, findsOneWidget);
  await tester.tap(quoteBtn);
  await tester.pumpAndSettle();
}
