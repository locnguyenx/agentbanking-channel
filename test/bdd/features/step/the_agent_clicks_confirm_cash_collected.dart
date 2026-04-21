import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentClicksConfirmCashCollected(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  final mainActionBtn = find.byKey(const Key('btn_main_action'));
  
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
  } else if (mainActionBtn.evaluate().isNotEmpty) {
    await tester.tap(mainActionBtn);
  }
  await tester.pumpAndSettle();
}
