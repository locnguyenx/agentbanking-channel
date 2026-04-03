import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theCustomersFundingSourceIsDuitnow(WidgetTester tester) async {
  await tester.pumpAndSettle();
  final dnowBtn = find.byKey(const Key('btn_duitnow'));
  expect(dnowBtn, findsOneWidget);
  await tester.tap(dnowBtn);
  await tester.pumpAndSettle();

  // Select DuitNow funding
  final finder = find.byKey(const Key('funding_source_DUITNOW_MOBILE'));
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}
