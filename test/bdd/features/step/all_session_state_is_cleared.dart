import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import '../../bdd_test_helper.dart';

/// Usage: all session state is cleared
Future<void> allSessionStateIsCleared(WidgetTester tester) async {
  final authStatus = bddContainer.read(authProvider).status;
  // Use unauthenticated status as clearing state
  expect(authStatus.toString(), contains('unauthenticated'));
}
