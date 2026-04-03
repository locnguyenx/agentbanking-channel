import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> theApplicantCompletesMykadOcrScanLivenessVideoAndEntersTheirSsmNumber(WidgetTester tester) async {
  final scanButton = find.byKey(const Key('btn_scan_mykad'));
  await tester.tap(scanButton);
  await tester.pump(const Duration(milliseconds: 200));
  await tester.pumpAndSettle();
  
  // Verify scan result
  expect(find.text('850101-01-5678'), findsOneWidget);

  // 2. Phone & OTP
  await tester.enterText(find.byKey(const Key('field_phone')), '0123456789');
  final sendBtn = find.byIcon(Icons.send);
  expect(sendBtn, findsOneWidget);
  await tester.tap(sendBtn);
  await tester.pumpAndSettle();
  
  // Wait for field_otp to appear
  for (int i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 200));
    if (find.byKey(const Key('field_otp')).evaluate().isNotEmpty) break;
  }
  
  await tester.enterText(find.byKey(const Key('field_otp')), '123456');
  await tester.tap(find.text('Verify'));
  await tester.pumpAndSettle();
  
  // Wait for liveness check simulation (3s delay in triggerLivenessCheck)
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();

  // 3. SSM
  await tester.enterText(find.byKey(const Key('field_ssm')), '202301012345');
  await tester.tap(find.text('Submit for Instant Activation'));
  await tester.pumpAndSettle();
}
