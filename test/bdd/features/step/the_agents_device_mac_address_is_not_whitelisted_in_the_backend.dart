import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the agent's device MAC address is not whitelisted in the backend
Future<void> theAgentsDeviceMacAddressIsNotWhitelistedInTheBackend(WidgetTester tester) async {
  // Mock the auth repository by passing isWhitelisted=false to pumpBddApp
  await pumpBddApp(tester, isAuthenticated: false, isWhitelisted: false);
}
