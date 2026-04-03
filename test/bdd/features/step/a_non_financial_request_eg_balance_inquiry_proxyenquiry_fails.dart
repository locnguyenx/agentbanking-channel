import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: a non_financial request (e.g., Balance Inquiry, ProxyEnquiry) fails
Future<void> aNonFinancialRequestEgBalanceInquiryProxyenquiryFails(
    WidgetTester tester) async {
  // await pumpBddApp(tester); // Redundant, reset state

  // Set up mock to fail on ProxyEnquiry
  mockTransactionRepository.performProxyEnquiryStub = (id, type) async {
    throw Exception('Backend Error');
  };

  // Trigger ProxyEnquiry (via Cash Deposit)
  // Search for the button with key "btn_deposit"
  final depositBtn = find.byKey(const Key('btn_deposit'));
  await tester.tap(depositBtn);
  await tester.pumpAndSettle();
  
  // Enter destination account
  final field = find.byKey(const Key('field_destination_account'));
  await tester.enterText(field, '12345678');
  await tester.pumpAndSettle();
  
  // Enter amount
  final amountField = find.byKey(const Key('field_amount'));
  await tester.enterText(amountField, '100');
  await tester.pumpAndSettle();

  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();
}
