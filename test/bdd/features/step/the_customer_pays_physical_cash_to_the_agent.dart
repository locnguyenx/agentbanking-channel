import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomerPaysPhysicalCashToTheAgent(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Just verify the AGREE button is visible; the NEXT step will tap it.
  expect(find.byKey(const Key('btn_confirm')), findsOneWidget);
}
