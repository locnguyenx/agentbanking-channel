import 'package:flutter_test/flutter_test.dart';

/// Usage: financial services remain disabled
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> financialServicesRemainDisabled(WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, true);
}
