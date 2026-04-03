import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart' as kyc_model;
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import '../../bdd_test_helper.dart';

Future<void> theKycPayloadReturnsStatusManualReview(WidgetTester tester) async {
  await tester.pump();
  bddContainer.read(onboardingProvider.notifier).debugSetState(
    OnboardingState(
      status: OnboardingStatus.manualReview,
      kycResponse: kyc_model.KycValidationResponse(
        isApproved: false,
        reasons: ['MANUAL_REVIEW'],
        kycId: 'REF-MANUAL',
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}
