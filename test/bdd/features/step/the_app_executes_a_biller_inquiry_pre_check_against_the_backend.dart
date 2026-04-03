import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the app executes a Biller Inquiry pre_check against the backend
Future<void> theAppExecutesABillerInquiryPreCheckAgainstTheBackend(
    WidgetTester tester) async {
  final proceedBtn = find.byKey(const Key('btn_main_action'));
  await tester.tap(proceedBtn);
  await tester.pumpAndSettle();
}
