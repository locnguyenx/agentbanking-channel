import 'package:flutter_test/flutter_test.dart';
import './the_agent_taps_proceed.dart';

/// Usage: the app performs the client_side STP hard cap pre_check
Future<void> theAppPerformsTheClientSideStpHardCapPreCheck(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  await theAgentTapsProceed(tester);
}
