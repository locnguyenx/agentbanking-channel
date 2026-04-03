import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the API rejects the request with error "ERR_BIZ_COMPLIANCE_FREEZE"
Future<void> theApiRejectsTheRequestWithErrorErrBizComplianceFreeze(WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, true);
  expect(compliance.reason, contains('ERR_BIZ_COMPLIANCE_FREEZE'));
}
