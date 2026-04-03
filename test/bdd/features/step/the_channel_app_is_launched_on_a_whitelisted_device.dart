import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the channel app is launched on a whitelisted device
Future<void> theChannelAppIsLaunchedOnAWhitelistedDevice(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: false);
}
