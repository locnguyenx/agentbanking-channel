import 'package:flutter_test/flutter_test.dart';

Future<void> theAppStopsTheOnboardingWorkflow(WidgetTester tester) async {
  // Verifying that the status is now MANUAL_REVIEW or FAILED
  await tester.pumpAndSettle();
  // We can't easily check the provider state here without the container, 
  // but we can check if a "Manual Review Required" or similar text is shown.
  expect(find.textContaining('Manual Review'), findsOneWidget);
}
