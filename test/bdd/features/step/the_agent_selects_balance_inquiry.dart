import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentSelectsBalanceInquiry(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  final inquiryBtn = find.byKey(const Key('btn_inquiry'));
  expect(inquiryBtn, findsOneWidget);
  await tester.tap(inquiryBtn);
  await tester.pumpAndSettle();

  // No fields for Inquiry, just PROCEED
  await tester.tap(find.byKey(const Key('btn_main_action')));
  await tester.pumpAndSettle();

  // Handle AGREE if present
  final agreeBtn = find.byKey(const Key('btn_confirm'));
  if (agreeBtn.evaluate().isNotEmpty) {
      await tester.tap(agreeBtn);
      await tester.pumpAndSettle();
  }
}
