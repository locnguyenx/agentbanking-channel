import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theAppDetectsABreachOfTheRm5000PerTransactionHardCap(
    WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Fixed: Find by Key to avoid "Found 2 widgets" error with the UI error display
  final token = find.byKey(const Key('bdd_status_token'));
  expect(token, findsOneWidget);
  expect(tester.widget<Text>(token).data, contains('ERR_VAL_AMOUNT_EXCEEDS_LIMIT'));
}
