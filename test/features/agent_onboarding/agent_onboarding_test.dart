import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:agentbanking_channel/features/agent_onboarding/providers/agent_onboarding_provider.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

@GenerateMocks([IMyKadScanner])
import 'agent_onboarding_test.mocks.dart';

void main() {
  late AgentOnboardingNotifier notifier;
  late MockIMyKadScanner mockScanner;

  setUp(() {
    mockScanner = MockIMyKadScanner();
    notifier = AgentOnboardingNotifier(myKadScanner: mockScanner);
  });

  test('scanMyKad populates myKadNumber on success', () async {
    when(mockScanner.scanMyKad()).thenAnswer((_) async => MyKadData(
      icNumber: '900101011234',
      fullName: 'TEST AGENT',
      address: 'STREET 1',
    ));

    await notifier.scanMyKad();

    expect(notifier.state.status, AgentOnboardingStatus.idle);
    expect(notifier.state.myKadNumber, '900101011234');
  });

  test('submitOnboarding transitions to activated for valid SSM (S10.1)', () async {
    // Manually set MyKad first
    notifier.state = notifier.state.copyWith(myKadNumber: '900101011234');

    await notifier.submitOnboarding('202301012345');

    expect(notifier.state.status, AgentOnboardingStatus.activated);
    expect(notifier.state.ssmNumber, '202301012345');
  });

  test('submitOnboarding transitions to manualReview for AML-prefixed SSM (S10.2)', () async {
    // Manually set MyKad first
    notifier.state = notifier.state.copyWith(myKadNumber: '900101011234');

    await notifier.submitOnboarding('AML999');

    expect(notifier.state.status, AgentOnboardingStatus.manualReview);
  });
}
