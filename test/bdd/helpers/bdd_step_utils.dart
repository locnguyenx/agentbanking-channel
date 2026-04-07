import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';


Future<void> selectFundingSourceIfNeeded(WidgetTester tester) async {
  final testName = tester.testDescription.toLowerCase();
  
  if (testName.contains('card funding') || testName.contains('atm card') || testName.contains('card authentication')) {
    final cardSource = find.byKey(const Key('funding_source_CARD_EMV'));
    debugPrint('DEBUG BDD: Searching for card source. Found = ${cardSource.evaluate().isNotEmpty}');
    if (cardSource.evaluate().isNotEmpty) {
      await tester.ensureVisible(cardSource);
      await tester.tap(cardSource);
      await tester.pumpAndSettle();
      debugPrint('DEBUG BDD: Tapped source successfully.');
    }






  }
 else if (testName.contains('mykad biometric') || testName.contains('mykad scan')) {
    final mykadSource = find.byKey(const Key('funding_source_MYKAD_BIOMETRIC'));
    if (mykadSource.evaluate().isNotEmpty) {
      await tester.tap(mykadSource);
      await tester.pumpAndSettle();
    }
  }
}
