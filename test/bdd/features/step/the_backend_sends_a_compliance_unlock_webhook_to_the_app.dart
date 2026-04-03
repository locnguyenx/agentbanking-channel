import 'package:flutter_test/flutter_test.dart';

/// Usage: the backend sends a Compliance Unlock webhook to the app
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendSendsAComplianceUnlockWebhookToTheApp(WidgetTester tester) async {
  bddContainer.read(complianceProvider.notifier).unlock();
}
