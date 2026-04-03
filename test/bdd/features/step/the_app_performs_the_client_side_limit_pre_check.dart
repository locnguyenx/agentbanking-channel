import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the app performs the client_side limit pre_check
Future<void> theAppPerformsTheClientSideLimitPreCheck(
    WidgetTester tester) async {
  final quoteBtn = find.byKey(const Key('btn_main_action'));
  await tester.tap(quoteBtn);
  await tester.pumpAndSettle();
}
