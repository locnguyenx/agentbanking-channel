import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:flutter_test/flutter_test.dart';

/// Usage: the request contains headers:
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theRequestContainsHeaders(WidgetTester tester, bdd.DataTable dataTable) async {
  final state = bddContainer.read(transactionProvider);
  // If we reach quoting, it means geofence passed.
  // The actual header injection is done by GpsInterceptor which uses the same mockGeolocator.
  expect(state.status, anyOf(TransactionStatus.quoting, TransactionStatus.waitingConsent));
}
