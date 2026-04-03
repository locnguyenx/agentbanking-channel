import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentConfirmsTheTransaction(WidgetTester tester) async {
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  // If not found, try text AGREE
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
  } else {
    final agreeBtn = find.text('AGREE');
    if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
    }
  }
  await tester.pumpAndSettle();
}
