import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent sees "Terminal Unlocked. You may resume operations."
Future<void> theAgentSeesTerminalUnlockedYouMayResumeOperations(
    WidgetTester tester) async {
  // Use a longer pump to ensure rebuilds complete
  await tester.pump(const Duration(seconds: 1));
  
  // Find specifically the banner text
  final finder = find.textContaining('Terminal Unlocked');
  expect(finder, findsOneWidget);
}
