import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the agent submits the transfer request
Future<void> theAgentSubmitsTheTransferRequest(WidgetTester tester) async {
  // 1. Click GET QUOTE
  final proceedBtn = find.byKey(const Key('btn_main_action'));
  await tester.tap(proceedBtn);
  await tester.pumpAndSettle();

  // 2. Click AGREE (if it's in waitingConsent)
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  if (confirmBtn.evaluate().isNotEmpty) {
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();
  }
}
