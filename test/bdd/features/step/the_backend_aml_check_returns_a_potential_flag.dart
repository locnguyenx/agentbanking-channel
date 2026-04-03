import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/agent_onboarding/providers/agent_onboarding_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theBackendAmlCheckReturnsAPotentialFlag(WidgetTester tester) async {
  // Use bddContainer from bdd_test_helper.dart to trigger manualReview
  bddContainer.read(agentOnboardingProvider.notifier).state = 
      bddContainer.read(agentOnboardingProvider).copyWith(status: AgentOnboardingStatus.manualReview);
  await tester.pumpAndSettle();
}
