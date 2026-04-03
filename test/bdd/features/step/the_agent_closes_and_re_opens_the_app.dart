import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent closes and re_opens the app
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAgentClosesAndReOpensTheApp(WidgetTester tester) async {
  await pumpBddApp(tester, clearStorage: false);
  // Ensure we call init to restore state from local storage
  await bddContainer.read(complianceProvider.notifier).init();
}
