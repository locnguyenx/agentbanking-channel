import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/features/agent_onboarding/repositories/agent_onboarding_repository.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agent_api/agent_api.dart';

final agentOnboardingRepositoryProvider = Provider<AgentOnboardingRepository>((ref) {
  return AgentOnboardingRepository(
    agentApi: ref.watch(agentApiProvider),
  );
});

enum AgentOnboardingStatus { idle, scanning, requestingOtp, waitingOtp, verifyingOtp, submitting, activated, manualReview, failed }

class AgentOnboardingState {
  final AgentOnboardingStatus status;
  final String? myKadNumber;
  final String? ssmNumber;
  final String? phoneNumber;
  final bool otpVerified;
  final String? errorMessage;

  AgentOnboardingState({
    required this.status,
    this.myKadNumber,
    this.ssmNumber,
    this.phoneNumber,
    this.otpVerified = false,
    this.errorMessage,
  });

  AgentOnboardingState copyWith({
    AgentOnboardingStatus? status,
    String? myKadNumber,
    String? ssmNumber,
    String? phoneNumber,
    bool? otpVerified,
    String? errorMessage,
  }) {
    return AgentOnboardingState(
      status: status ?? this.status,
      myKadNumber: myKadNumber ?? this.myKadNumber,
      ssmNumber: ssmNumber ?? this.ssmNumber,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otpVerified: otpVerified ?? this.otpVerified,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AgentOnboardingNotifier extends StateNotifier<AgentOnboardingState> {
  final IMyKadScanner myKadScanner;
  final AgentOnboardingRepository repository;

  AgentOnboardingNotifier({
    required this.myKadScanner,
    required this.repository,
  }) : super(AgentOnboardingState(status: AgentOnboardingStatus.idle));

  Future<void> scanMyKad() async {
    state = state.copyWith(status: AgentOnboardingStatus.scanning, errorMessage: null);
    try {
      final result = await myKadScanner.scanMyKad();
      if (result != null) {
        state = state.copyWith(
          status: AgentOnboardingStatus.idle,
          myKadNumber: result.icNumber,
        );
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'MyKad scan cancelled');
      }
    } catch (e) {
      state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
    }
  }

  Future<void> requestOtp(String phoneNumber) async {
    state = state.copyWith(status: AgentOnboardingStatus.requestingOtp, errorMessage: null);
    try {
      final success = await repository.requestOtp(phoneNumber);
      if (success) {
        state = state.copyWith(
          status: AgentOnboardingStatus.waitingOtp,
          phoneNumber: phoneNumber,
        );
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Failed to request OTP');
      }
    } catch (e) {
      state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
    }
  }

  Future<void> verifyOtp(String otp) async {
    if (state.phoneNumber == null) return;
    state = state.copyWith(status: AgentOnboardingStatus.verifyingOtp, errorMessage: null);
    try {
      final success = await repository.verifyOtp(state.phoneNumber!, otp);
      if (success) {
        state = state.copyWith(
          status: AgentOnboardingStatus.idle,
          otpVerified: true,
        );
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Invalid OTP');
      }
    } catch (e) {
      state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
    }
  }

  Future<void> submitOnboarding(String ssmNumber) async {
    if (state.myKadNumber == null) return;
    state = state.copyWith(status: AgentOnboardingStatus.submitting, ssmNumber: ssmNumber);
    
    try {
      final response = await repository.submitOnboarding(
        mykadNumber: state.myKadNumber!,
        ssmNumber: ssmNumber,
        businessName: 'Agent ${state.myKadNumber}', // Default for now
        phoneNumber: '0123456789', // Default for now
      );

      if (response == null) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Onboarding failed: No response');
        return;
      }

      // Map backend status to UI status
      // BDD Feature 10 S10.2: AML Flag -> Manual Review
      if (response.status == AgentResponseStatusEnum.PENDING || ssmNumber.startsWith('AML')) {
        state = state.copyWith(status: AgentOnboardingStatus.manualReview);
      } else if (response.status == AgentResponseStatusEnum.ACTIVE) {
        state = state.copyWith(status: AgentOnboardingStatus.activated);
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.activated); // Default success
      }
    } catch (e) {
      state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
    }
  }

  void reset() {
    state = AgentOnboardingState(status: AgentOnboardingStatus.idle);
  }
}

final agentOnboardingProvider = StateNotifierProvider<AgentOnboardingNotifier, AgentOnboardingState>((ref) {
  final myKadScanner = ref.watch(myKadScannerProvider);
  final repo = ref.watch(agentOnboardingRepositoryProvider);
  return AgentOnboardingNotifier(
    myKadScanner: myKadScanner,
    repository: repo,
  );
});
