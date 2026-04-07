import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';
import 'package:agentbanking_channel/main.dart';
import '../../bdd_test_helper.dart';

Future<void> theMatchOnCardThumbprintCheckReturnsNoMatchOrFailed(WidgetTester tester) async {
  // Navigate to KycFlowScreen if not already there
  if (find.byType(KycFlowScreen).evaluate().isEmpty) {
    final context = navigatorKey.currentContext!;
    Navigator.push(context, MaterialPageRoute(builder: (_) => const KycFlowScreen()));
    await tester.pumpAndSettle();
  }
}
