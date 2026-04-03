import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentConfirmsCashReceived(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final confirmBtn = find.byKey(const Key('btn_confirm'));
  await tester.tap(confirmBtn);
  await tester.pumpAndSettle();
}
