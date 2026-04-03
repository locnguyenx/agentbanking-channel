import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/agent_onboarding/screens/agent_onboarding_screen.dart';
import '../../bdd_test_helper.dart';

Future<void> aProspectiveMicroAgentOpensTheSelfOnboardingFlowOnThePos(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: false);
  // For mock, we just assume it's opened or we navigate to it.
  // Assuming a button for onboarding exists on the login or main screen.
  final onboardingBtn = find.byKey(const Key('btn_go_to_onboard'));
  expect(onboardingBtn, findsOneWidget);
  await tester.tap(onboardingBtn);
  await tester.pumpAndSettle();
  
  // Verify we are on Onboarding Screen
  expect(find.byType(AgentOnboardingScreen), findsOneWidget);
}
