import 'package:flutter_test/flutter_test.dart';

Future<void> theAppFiresPostApiv1billpayBillercodeastroFundingsourcecash(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  final confirmBtn = find.text('Confirm');
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }
}
