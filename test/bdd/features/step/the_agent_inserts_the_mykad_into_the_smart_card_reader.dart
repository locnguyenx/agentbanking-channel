import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';

Future<void> theAgentInsertsTheMykadIntoTheSmartCardReader(WidgetTester tester) async {
  // Use pump instead of pumpAndSettle to avoid timeout from loader
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  // Verify we are on KycFlowScreen
  expect(find.byType(KycFlowScreen), findsOneWidget);
  // We simulate insertion by tapping the 'START MYKAD SCAN' button in KycFlowScreen
  final startButton = find.text('START MYKAD SCAN');
  expect(startButton, findsOneWidget);
  await tester.tap(startButton);
  await tester.pumpAndSettle(); // Wait for scan to complete and state to transition
}
