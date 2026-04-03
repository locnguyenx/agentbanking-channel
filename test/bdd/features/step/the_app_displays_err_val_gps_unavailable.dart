import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

Future<void> theAppDisplaysErrValGpsUnavailable(WidgetTester tester) async {
  final state = bddContainer.read(transactionProvider);
  expect(state.error, 'ERR_GPS_UNAVAILABLE');
}
