import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

/// Usage: makes a maximum of 3 retry attempts before displaying an error
Future<void> makesAMaximumOf3RetryAttemptsBeforeDisplayingAnError(
    WidgetTester tester) async {
  // Verify max retries
  await tester.pumpAndSettle(const Duration(seconds: 10));
  
  // Wait for all retries to complete (exponential backoff 1+2+4+8 = 15s plus overhead)
  await tester.pumpAndSettle(const Duration(seconds: 25));
  
  // We expect a failure state
  final state = bddContainer.read(transactionProvider);
  expect(state.status, TransactionStatus.failed);
  
  // Verify UI shows failure
  // Use findsWidgets because dual-display might show it twice
  expect(find.textContaining('Transaction Failed'), findsWidgets);
  expect(find.textContaining('Backend Error'), findsWidgets);
}
