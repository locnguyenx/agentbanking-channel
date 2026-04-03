import 'package:flutter_test/flutter_test.dart';

Future<void> anEpfContributionReceiptIsPrinted(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('Success!'), findsOneWidget);
}
