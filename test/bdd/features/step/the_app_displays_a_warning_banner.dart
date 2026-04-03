import 'package:flutter_test/flutter_test.dart';

/// Usage: the app displays a warning banner
Future<void> theAppDisplaysAWarningBanner(WidgetTester tester) async {
  // Assuming the warning banner contains specific text related to EOD
  expect(find.textContaining('End of Day Settlement approaching'), findsOneWidget);
}
