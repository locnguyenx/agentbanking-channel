import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';

/// Usage: the app proceeds to send the payload to /api/v1/kyc/verify
Future<void> theAppProceedsToSendThePayloadToApiv1kycverify(
    WidgetTester tester) async {
  // Simulate sending payload
  final currentState = bddContainer.read(onboardingProvider);
  bddContainer.read(onboardingProvider.notifier).debugSetState(currentState.copyWith(
    status: OnboardingStatus.validatingKyc,
  ));
  await tester.pump();
  expect(find.text('VALIDATING IDENTITY...'), findsOneWidget);
}
