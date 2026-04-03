import 'package:flutter_test/flutter_test.dart';

/// Usage: displays "ERR_VAL_INVALID_PHONE_FORMAT"
Future<void> displaysErrValInvalidPhoneFormat(WidgetTester tester) async {
  expect(find.textContaining('Invalid').first, findsOneWidget);
}
