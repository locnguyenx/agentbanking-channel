import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

Future<void> theSystemDetectsAnExpiredJwtToken(WidgetTester tester) async {
  bddContainer.read(authProvider.notifier).debugTriggerSessionExpired();
  await tester.pump(); // Show dialog
  await tester.pump(const Duration(milliseconds: 100)); // Animation
}
