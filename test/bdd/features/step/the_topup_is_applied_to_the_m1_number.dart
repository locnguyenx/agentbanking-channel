import 'package:flutter_test/flutter_test.dart';

Future<void> theTopupIsAppliedToTheM1Number(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.text('Success!'), findsOneWidget);
}
