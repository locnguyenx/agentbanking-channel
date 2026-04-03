import 'package:flutter_test/flutter_test.dart';

/// Usage: the geofence check fails
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theGeofenceCheckFails(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.status, TransactionStatus.failed);
}
