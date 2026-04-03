import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

Future<void> theCustomerInsertsTheirMykadAndPressesThumbOnBiometricScanner(WidgetTester tester) async {
  await tester.pumpAndSettle();

  // 1. If we are at waitingConsent (has quote), tap CONFIRM
  if (find.byKey(const Key('btn_confirm')).evaluate().isNotEmpty) {
     await tester.tap(find.byKey(const Key('btn_confirm')));
     await tester.pumpAndSettle();
  }
  
  // 2. Wait for next state (waitingMyKadScan OR success if very fast)
  bool found = false;
  for (int i = 0; i < 20; i++) {
    await tester.pump(const Duration(milliseconds: 100));
    final state = bddContainer.read(transactionProvider);
    if (state.status == TransactionStatus.waitingMyKadScan || state.status == TransactionStatus.success) {
      found = true;
      break;
    }
  }
  
  if (!found) {
    final status = bddContainer.read(transactionProvider);
    throw Exception('Timed out waiting for next state. Current status: ${status.status}');
  }

  await tester.pumpAndSettle();
}
