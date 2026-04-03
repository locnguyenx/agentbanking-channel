import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentClicksConfirmCashCollected(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }
}
