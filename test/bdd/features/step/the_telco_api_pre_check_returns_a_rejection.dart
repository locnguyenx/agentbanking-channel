import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../helpers/app_harness.dart';
import '../../helpers/mock_factory.dart';

Future<void> theTelcoApiPreCheckReturnsARejection(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // 1. Configure mock to fail
  final repo = bddContainer.read(transactionRepositoryProvider) as MockTransactionRepository;
  repo.shouldFail = true;

  // 2. Ensure telco is selected (if not already)
  final dropdown = find.byType(DropdownButtonFormField<String>);
  if (dropdown.evaluate().isNotEmpty) {
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text('CELCOM').last);
      await tester.pumpAndSettle();
  }

  // 3. Ensure amount is entered (if not already)
  final amountField = find.widgetWithText(TextFormField, 'Amount');
  if (amountField.evaluate().isNotEmpty) {
      await tester.enterText(amountField, '50');
      await tester.pumpAndSettle();
  }

  // 4. Tap the main action button to trigger pre-check
  final proceed = find.byKey(const Key('btn_main_action'));
  if (proceed.evaluate().isNotEmpty) {
      await tester.tap(proceed);
      await tester.pumpAndSettle();
  }
}
