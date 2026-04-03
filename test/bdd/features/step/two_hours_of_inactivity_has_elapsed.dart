import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import '../../bdd_test_helper.dart';

/// Usage: two hours of inactivity has elapsed
Future<void> twoHoursOfInactivityHasElapsed(WidgetTester tester) async {
  // Use debug trigger to set status to expired
  bddContainer.read(authProvider.notifier).debugTriggerSessionExpired();
  await tester.pump();
}
