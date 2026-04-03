import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the geofence check passes (distance < 100m)
Future<void> theGeofenceCheckPassesDistance100m(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.error, isNot('ERR_VAL_GEOFENCE_BREACH'));
  expect(state.status, isNot(TransactionStatus.failed));
}
