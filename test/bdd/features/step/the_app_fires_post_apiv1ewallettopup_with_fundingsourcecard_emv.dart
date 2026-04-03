import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


Future<void> theAppFiresPostApiv1ewallettopupWithFundingsourcecardEmv(WidgetTester tester) async {
  await tester.pumpAndSettle();
  expect(find.byKey(const Key('status_success')), findsOneWidget);
}
