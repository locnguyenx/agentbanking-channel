import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import './the_agent_clicks_confirm_cash_collected.dart';

Future<void> theAgentAcceptsCashAndClicksConfirmCashCollected(
    WidgetTester tester) async {
  await theAgentClicksConfirmCashCollected(tester);
}
