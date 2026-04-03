import 'package:flutter_test/flutter_test.dart';
import 'package:bdd_widget_test/data_table.dart' as bdd;
import 'package:agentbanking_channel/features/merchant/providers/merchant_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendPerformsSplitAccountingAutomatically(WidgetTester tester, bdd.DataTable dataTable) async {
  final state = bddContainer.read(merchantProvider);
  expect(state.status, MerchantStatus.success);
}
