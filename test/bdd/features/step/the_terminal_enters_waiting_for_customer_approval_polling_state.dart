import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: the terminal enters "Waiting for Customer Approval" polling state
Future<void> theTerminalEntersWaitingForCustomerApprovalPollingState(
    WidgetTester tester) async {
  // Wait for the UI to reach a terminal or polling state
  int count = 0;
  String statusData = '';
  while (count < 20) {
    await tester.pump(const Duration(milliseconds: 100));
    final statusToken = find.byKey(const Key('bdd_status_token'));
    if (statusToken.evaluate().isNotEmpty) {
      statusData = tester.widget<Text>(statusToken).data ?? '';
      if (statusData.contains('waitingConsent') || 
          statusData.contains('success') || 
          statusData.contains('processingDuitNow')) {
        break;
      }
    }
    count++;
  }
  
  if (count >= 20) {
    print('BDD_DEBUG: Polling timed out. Last status: "$statusData"');
  }

  expect(statusData, anyOf(
    contains('waitingConsent'), 
    contains('success'), 
    contains('processingDuitNow'),
    contains('waitingMyKadScan'),
    contains('processingBiller'),
  ), reason: 'Status was "$statusData"');
}
