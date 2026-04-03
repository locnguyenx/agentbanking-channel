import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomersSarawakPayEwalletIsCredited(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('Success!'), findsOneWidget);
}
