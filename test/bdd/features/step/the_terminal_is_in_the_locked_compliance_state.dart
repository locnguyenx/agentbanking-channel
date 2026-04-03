import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

/// Usage: the terminal is in the "LOCKED" compliance state
Future<void> theTerminalIsInTheLockedComplianceState(WidgetTester tester) async {
  bddContainer.read(complianceProvider.notifier).freeze('BDD_LOCK');
  await tester.pump(const Duration(milliseconds: 500));
}
