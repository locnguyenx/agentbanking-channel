import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentScansTheCustomersMykadOnThePosTerminal(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  await bddContainer.read(transactionProvider.notifier).recordMyKadScan('MYKAD-800101-14-5566', 'John Doe');
  
  await tester.pumpAndSettle();
}
