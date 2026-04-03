import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

/// Usage: the JWT token is deleted from secure storage
Future<void> theJwtTokenIsDeletedFromSecureStorage(WidgetTester tester) async {
  expect(mockSecureStorage.jwt, isNull);
}
