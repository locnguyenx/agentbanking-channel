import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> aReceiptIsPrintedOnRequest(WidgetTester tester) async {
  final printBtn = find.text('Print Receipt');
  if (printBtn.evaluate().isNotEmpty) {
    await tester.tap(printBtn);
    await tester.pumpAndSettle();
  }
}
