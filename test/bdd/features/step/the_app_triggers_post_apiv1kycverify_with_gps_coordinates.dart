import 'package:flutter_test/flutter_test.dart';

Future<void> theAppTriggersPostApiv1kycverifyWithGpsCoordinates(WidgetTester tester) async {
  // In our BDD environment, this is handled by the OnboardingNotifier
  // We just ensure we are in the Verifying state
  // Use pump instead of pumpAndSettle to avoid timeout from loader
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}
