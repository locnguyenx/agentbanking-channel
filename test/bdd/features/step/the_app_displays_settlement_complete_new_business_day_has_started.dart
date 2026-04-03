import 'package:flutter_test/flutter_test.dart';

/// Usage: the app displays "Settlement Complete. New business day has started."
Future<void> theAppDisplaysSettlementCompleteNewBusinessDayHasStarted(WidgetTester tester) async {
  expect(find.textContaining('Settlement Complete'), findsOneWidget);
}
