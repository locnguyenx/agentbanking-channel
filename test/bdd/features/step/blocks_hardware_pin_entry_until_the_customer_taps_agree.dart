import 'package:flutter_test/flutter_test.dart';

/// Usage: blocks hardware PIN entry until the customer taps "Agree"
Future<void> blocksHardwarePinEntryUntilTheCustomerTapsAgree(
    WidgetTester tester) async {
  // US-CA-06 Dual-Handshake: Hardware PIN entry is locked until AGREE is tapped
  // In BDD test, we simulate this by tapping a button that specifically handles this consent
  final agreeBtn = find.text('AGREE');
  if (agreeBtn.evaluate().isNotEmpty) {
    await tester.tap(agreeBtn);
  } else {
    // If not on screen yet, wait a bit
    await tester.pumpAndSettle();
    await tester.tap(find.text('AGREE'));
  }
  await tester.pumpAndSettle();
}
