import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: a JWT session is created and stored securely
Future<void> aJwtSessionIsCreatedAndStoredSecurely(WidgetTester tester) async {
  // Verify JWT is in mock secure storage
  expect(mockSecureStorage.jwt, isNotNull);
}
