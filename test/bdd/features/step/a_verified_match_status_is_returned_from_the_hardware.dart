import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';

/// Usage: a verified "MATCH" status is returned from the hardware
Future<void> aVerifiedMatchStatusIsReturnedFromTheHardware(
    WidgetTester tester) async {
  // Simulate biometric match success -> moves to product selection
  final currentState = bddContainer.read(onboardingProvider);
  bddContainer.read(onboardingProvider.notifier).debugSetState(currentState.copyWith(
    status: OnboardingStatus.selectingProduct,
  ));
  await tester.pump();
}
