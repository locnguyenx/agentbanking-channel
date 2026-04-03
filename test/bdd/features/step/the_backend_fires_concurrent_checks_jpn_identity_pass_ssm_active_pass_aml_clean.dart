import 'package:flutter_test/flutter_test.dart';

Future<void> theBackendFiresConcurrentChecksJpnIdentityPassSsmActivePassAmlClean(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('KYC VERIFIED'), findsOneWidget);
}
