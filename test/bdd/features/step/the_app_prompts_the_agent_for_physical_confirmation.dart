import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppPromptsTheAgentForPhysicalConfirmation(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Expect the confirmation button - unified key in TransactionFlowScreen
  // Just verify button exists. Tapping is done in the next step (Then the UI requires...)
  expect(find.byKey(const Key('btn_confirm')), findsOneWidget);
}
