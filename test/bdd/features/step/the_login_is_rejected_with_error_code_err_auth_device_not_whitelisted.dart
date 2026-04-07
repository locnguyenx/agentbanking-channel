import 'package:flutter_test/flutter_test.dart';

/// Usage: the login is rejected with error code "ERR_AUTH_DEVICE_NOT_WHITELISTED"
Future<void> theLoginIsRejectedWithErrorCodeErrAuthDeviceNotWhitelisted(WidgetTester tester) async {
  // SnackBar might need some time to animate in
  await tester.pump(const Duration(milliseconds: 500));
  expect(find.textContaining('Device not whitelisted'), findsOneWidget);
}
