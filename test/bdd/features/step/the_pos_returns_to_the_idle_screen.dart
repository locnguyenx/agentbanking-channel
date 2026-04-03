import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/login_screen.dart';

Future<void> thePosReturnsToTheIdleScreen(WidgetTester tester) async {
  await tester.pumpAndSettle();
  
  // If we are on the onboarding success or manual review screen, we need to tap Finish
  final finishBtn = find.byKey(const Key('btn_finish'));
  if (finishBtn.evaluate().isNotEmpty) {
    await tester.tap(finishBtn);
    await tester.pumpAndSettle();
  }

  // Expect LoginScreen (the idle screen for this test case)
  expect(find.byType(LoginScreen), findsOneWidget);
}
