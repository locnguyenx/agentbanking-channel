import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';
import 'package:agentbanking_channel/main.dart';
import '../../bdd_test_helper.dart';

Future<void> anUnregisteredCustomerWantsToOpenAnAccount(WidgetTester tester) async {
  await pumpBddApp(tester, isAuthenticated: false);
  
  // Ensure we are on LoginScreen and then push KycFlowScreen manually
  // since there is no "Self Onboarding" button on the production LoginScreen yet.
  final context = navigatorKey.currentContext!;
  Navigator.push(context, MaterialPageRoute(builder: (_) => KycFlowScreen()));
  await tester.pumpAndSettle();
}
