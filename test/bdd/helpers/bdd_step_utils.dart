import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> selectFundingSourceIfNeeded(WidgetTester tester) async {
  final testName = tester.testDescription.toLowerCase();
  
  if (testName.contains('card funding') || testName.contains('atm card')) {
    final cardSource = find.byKey(const Key('funding_source_CARD_EMV'));
    if (cardSource.evaluate().isNotEmpty) {
      await tester.tap(cardSource);
      await tester.pumpAndSettle();
    }
  } else if (testName.contains('mykad biometric') || testName.contains('mykad scan')) {
    final mykadSource = find.byKey(const Key('funding_source_MYKAD_BIOMETRIC'));
    if (mykadSource.evaluate().isNotEmpty) {
      await tester.tap(mykadSource);
      await tester.pumpAndSettle();
    }
  }
}
