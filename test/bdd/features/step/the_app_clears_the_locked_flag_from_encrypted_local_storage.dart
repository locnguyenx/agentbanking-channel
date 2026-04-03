import 'package:flutter_test/flutter_test.dart';

/// Usage: the app clears the LOCKED flag from encrypted local storage
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theAppClearsTheLockedFlagFromEncryptedLocalStorage(WidgetTester tester) async {
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, false);
}
