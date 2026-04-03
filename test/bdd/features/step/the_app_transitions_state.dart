import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';

/// Usage: the app transitions state
Future<void> theAppTransitionsState(WidgetTester tester) async {
  // Simulate transition to Face AI liveness
  final currentState = bddContainer.read(onboardingProvider);
  bddContainer.read(onboardingProvider.notifier).debugSetState(currentState.copyWith(
    status: OnboardingStatus.livenessProcessing,
  ));
  await tester.pump();
  // Logic: Wait for state change to reflect in UI
  await tester.pump(const Duration(milliseconds: 100));
}
