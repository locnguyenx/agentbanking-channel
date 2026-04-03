import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAgentTapsProceed(WidgetTester tester) async {
  final proceedBtn = find.text('PROCEED');
  final getQuoteBtn = find.text('GET QUOTE');
  final mainActionBtn = find.byKey(const Key('btn_main_action'));
  
  if (proceedBtn.evaluate().isNotEmpty) {
    await tester.tap(proceedBtn);
  } else if (getQuoteBtn.evaluate().isNotEmpty) {
    await tester.tap(getQuoteBtn);
  } else if (mainActionBtn.evaluate().isNotEmpty) {
    await tester.tap(mainActionBtn);
  } else {
    final nextBtn = find.text('NEXT');
    if (nextBtn.evaluate().isNotEmpty) {
      await tester.tap(nextBtn);
    }
  }
  await tester.pump();
}
