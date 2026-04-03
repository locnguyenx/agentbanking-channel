import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the session is not created
Future<void> theSessionIsNotCreated(WidgetTester tester) async {
  expect(mockSecureStorage.jwt, isNull);
}
