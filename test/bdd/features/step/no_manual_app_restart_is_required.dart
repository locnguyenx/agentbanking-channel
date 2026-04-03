import 'package:flutter_test/flutter_test.dart';

/// Usage: no manual app restart is required
Future<void> noManualAppRestartIsRequired(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // If the dashboard is visible, then no restart was required (it happened automatically)
  expect(find.textContaining('Dashboard'), findsOneWidget);
}
