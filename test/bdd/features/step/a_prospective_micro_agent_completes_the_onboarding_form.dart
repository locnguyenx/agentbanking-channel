import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';

Future<void> aProspectiveMicroAgentCompletesTheOnboardingForm(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: false);
  await tester.pumpAndSettle();
  final onboardBtn = find.byKey(const Key('btn_go_to_onboard'));
  await tester.tap(onboardBtn);
  await tester.pumpAndSettle();
}
