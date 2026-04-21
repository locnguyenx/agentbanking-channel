import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/agent_onboarding/providers/agent_onboarding_provider.dart';
import 'package:agentbanking_channel/features/agent_onboarding/repositories/agent_onboarding_repository.dart';
import 'package:agent_api/agent_api.dart';

class FakeScanner implements IMyKadScanner {
  MyKadData? nextResult;
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<MyKadData?> scanMyKad() async => nextResult;
}

class FakeAgentOnboardingRepository implements AgentOnboardingRepository {
  SubmissionResponse? nextResponse;
  AgentResponse? nextAgentStatus;
  bool nextOtpResult = true;
  
  @override
  AgentControllerOnboardingServiceApi get agentApi => throw UnimplementedError();

  @override
  AgentOnboardingControllerOnboardingServiceApi get onboardingApi => throw UnimplementedError();

  @override
  Future<bool> requestOtp(String phoneNumber) async => nextOtpResult;

  @override
  Future<bool> verifyOtp(String phoneNumber, String otp) async => nextOtpResult;

  @override
  Future<SubmissionResponse?> submitOnboarding({
    required String mykadNumber,
    required String ssmNumber,
    required String businessName,
    required String phoneNumber,
    double lat = 3.1390,
    double lng = 101.6869,
  }) async {
    return nextResponse;
  }

  @override
  Future<AgentResponse?> getAgentStatus(String agentId) async {
    return nextAgentStatus;
  }
}

void main() {
  late AgentOnboardingNotifier notifier;
  late FakeScanner fakeScanner;
  late FakeAgentOnboardingRepository fakeRepo;

  setUp(() {
    fakeScanner = FakeScanner();
    fakeRepo = FakeAgentOnboardingRepository();
    notifier = AgentOnboardingNotifier(
      myKadScanner: fakeScanner,
      repository: fakeRepo,
    );
  });

  test('scanMyKad populates myKadNumber on success', () async {
    fakeScanner.nextResult = MyKadData(
      icNumber: '900101011234',
      fullName: 'TEST AGENT',
      address: 'STREET 1',
    );

    await notifier.scanMyKad();

    expect(notifier.state.status, AgentOnboardingStatus.idle);
    expect(notifier.state.myKadNumber, '900101011234');
  });

  test('requestOtp transitions to waitingOtp on success', () async {
    await notifier.requestOtp('0123456789');

    expect(notifier.state.status, AgentOnboardingStatus.waitingOtp);
    expect(notifier.state.phoneNumber, '0123456789');
  });

  test('verifyOtp transitions to livenessCheck with otpVerified true on success', () async {
    notifier.state = notifier.state.copyWith(phoneNumber: '0123456789');
    
    await notifier.verifyOtp('123456');

    expect(notifier.state.status, AgentOnboardingStatus.livenessCheck);
    expect(notifier.state.otpVerified, isTrue);
  });

  test('triggerLivenessCheck transitions to idle on completion', () async {
    notifier.state = notifier.state.copyWith(
      status: AgentOnboardingStatus.livenessCheck,
      otpVerified: true,
    );

    await notifier.triggerLivenessCheck();

    expect(notifier.state.status, AgentOnboardingStatus.idle);
  });

  test('submitOnboarding transitions to activated for valid SSM (S10.1)', () async {
    notifier.state = notifier.state.copyWith(
      myKadNumber: '900101011234',
      phoneNumber: '0123456789',
      otpVerified: true,
    );
    fakeRepo.nextResponse = SubmissionResponse((b) => b..status = 'ACTIVE');

    await notifier.submitOnboarding('202301012345');

    expect(notifier.state.status, AgentOnboardingStatus.activated);
    expect(notifier.state.ssmNumber, '202301012345');
  });

  test('submitOnboarding transitions to manualReview for AML-prefixed SSM (S10.2)', () async {
    notifier.state = notifier.state.copyWith(
      myKadNumber: '900101011234',
      phoneNumber: '0123456789',
      otpVerified: true,
    );
    fakeRepo.nextResponse = SubmissionResponse((b) => b..status = 'PENDING');

    await notifier.submitOnboarding('AML999');

    expect(notifier.state.status, AgentOnboardingStatus.manualReview);
  });

  test('submitOnboarding transitions to failed when repository returns null', () async {
    notifier.state = notifier.state.copyWith(myKadNumber: '900101011234');
    fakeRepo.nextResponse = null;

    await notifier.submitOnboarding('123');

    expect(notifier.state.status, AgentOnboardingStatus.failed);
    expect(notifier.state.errorMessage, contains('No response'));
  });
}
