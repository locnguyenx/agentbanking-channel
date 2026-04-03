import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent_facing display shows "Estimated Commission: RM 0.50"
Future<void> theAgentFacingDisplayShowsEstimatedCommissionRm050(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.textContaining('AGENT COMMISSION'), findsOneWidget);
  expect(find.textContaining('RM 0.50'), findsOneWidget);
}
