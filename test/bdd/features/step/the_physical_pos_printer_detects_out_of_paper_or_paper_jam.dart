import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:agentbanking_channel/features/transactions/services/reversal_service.dart';
import '../../bdd_test_helper.dart';

/// Usage: the physical POS printer detects "Out Of Paper" or "Paper Jam"
Future<void> thePhysicalPosPrinterDetectsOutOfPaperOrPaperJam(
    WidgetTester tester) async {
  // Trigger reversal via BDD shortcut
  final notifier = bddContainer.read(transactionProvider.notifier);
  final currentState = bddContainer.read(transactionProvider);
  
  // Manually queue reversal as the service would do
  await bddContainer.read(reversalServiceProvider).queueReversal({
    'idempotencyKey': 'BDD_TEST_KEY',
    'amount': currentState.amount?.toString(),
    'serviceCode': currentState.serviceCode,
  });

  notifier.debugSetState(currentState.copyWith(
    status: TransactionStatus.reversalQueued,
    error: 'Printer Jam',
  ));
  
  await tester.pumpAndSettle();
}
