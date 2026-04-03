import 'package:flutter_test/flutter_test.dart';

/// Usage: financial services are re_enabled automatically
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> financialServicesAreReEnabledAutomatically(WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, false);
}
