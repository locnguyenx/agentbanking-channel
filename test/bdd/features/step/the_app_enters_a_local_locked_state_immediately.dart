import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the app enters a local "LOCKED" state immediately
Future<void> theAppEntersALocalLockedStateImmediately(
    WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, true);
}
