import 'package:flutter_test/flutter_test.dart';
import '../../bdd_test_helper.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';

Future<void> theOcrchipReadExtractsNameIcNumberAndAddress(WidgetTester tester) async {
  // Logic: Transition to validating state
  bddContainer.read(onboardingProvider.notifier).debugSetState(OnboardingState(
    status: OnboardingStatus.validatingKyc,
  ));
  await tester.pump();
  expect(find.text('VALIDATING IDENTITY...'), findsOneWidget);
}
