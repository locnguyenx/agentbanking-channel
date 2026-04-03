import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theKycPayloadReturnsStatusAutoApproved(WidgetTester tester) async {
  // Navigation happens in the Gherkin step "an unregistered customer wants to open an account"
  // which calls anUnregisteredCustomerWantsToOpenAnAccount(tester).
  
  // Set the success state directly
  bddContainer.read(onboardingProvider.notifier).debugSetState(
    OnboardingState(status: OnboardingStatus.success),
  );
  await tester.pumpAndSettle();
}
