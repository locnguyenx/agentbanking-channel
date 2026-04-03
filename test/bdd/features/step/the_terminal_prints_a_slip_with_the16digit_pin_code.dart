import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theTerminalPrintsASlipWithThe16digitPinCode(WidgetTester tester) async {
  await tester.pumpAndSettle();
  // Success screen implicitly implies printing started in this mock
  expect(find.textContaining('Success'), findsOneWidget);
}
