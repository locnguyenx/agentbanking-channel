import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theLockedStateIsRestoredFromEncryptedLocalStorage(WidgetTester tester) async {
  // Allow init() microtask to finish
  await tester.pump(const Duration(seconds: 1));

  final lockedText = find.textContaining('COMPLIANCE REVIEW');
  expect(lockedText, findsOneWidget);
  
  final compliance = bddContainer.read(complianceProvider);
  expect(compliance.isFrozen, true);
}
