import 'package:flutter_test/flutter_test.dart';

/// Usage: the app fires POST /api/v1/withdrawal
Future<void> theAppFiresPostApiv1withdrawal(WidgetTester tester) async {
  // In mocks, processing resolves to success
  expect(find.textContaining('Status: success'), findsOneWidget);
}
