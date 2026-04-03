import 'dart:async';
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

enum AgentOnboardingStatus { idle, scanning, requestingOtp, waitingOtp, verifyingOtp, livenessCheck, submitting, activated, manualReview, failed }

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
  bool _mounted = true;
  Timer? _livenessTimer;

  AgentOnboardingNotifier({
    required this.myKadScanner,
    required this.repository,
  }) : super(AgentOnboardingState(status: AgentOnboardingStatus.idle));

  Future<void> scanMyKad() async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: AgentOnboardingStatus.scanning, errorMessage: null);
    }
    try {
      final result = await myKadScanner.scanMyKad();
      if (!_mounted) return;
      if (result != null) {
        if (_mounted) {
          state = state.copyWith(
            status: AgentOnboardingStatus.idle,
            myKadNumber: result.icNumber,
          );
        }
      } else {
        if (_mounted) {
          state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'MyKad scan cancelled');
        }
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
      }
    }
  }

  Future<void> requestOtp(String phoneNumber) async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: AgentOnboardingStatus.requestingOtp, errorMessage: null);
    }
    try {
      final success = await repository.requestOtp(phoneNumber);
      if (!_mounted) return;
      if (success) {
        if (_mounted) {
          state = state.copyWith(
            status: AgentOnboardingStatus.waitingOtp,
            phoneNumber: phoneNumber,
          );
        }
      } else {
        if (_mounted) {
          state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Failed to request OTP');
        }
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
      }
    }
  }

  Future<void> verifyOtp(String otp) async {
    if (!_mounted) return;
    if (state.phoneNumber == null) return;
    state = state.copyWith(status: AgentOnboardingStatus.verifyingOtp, errorMessage: null);
    try {
      final success = await repository.verifyOtp(state.phoneNumber!, otp);
      if (!_mounted) return;
      if (success) {
        state = state.copyWith(
          status: AgentOnboardingStatus.livenessCheck,
          otpVerified: true,
        );
        // Automatically trigger liveness simulation with managed timer
        // BDD Stabilization: Use a Timer to allow UI to render the liveness state
        _livenessTimer = Timer(const Duration(seconds: 1), () => triggerLivenessCheck());
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Invalid OTP');
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
      }
    }
  }

  Future<void> triggerLivenessCheck() async {
    if (!_mounted) return;
    if (state.status != AgentOnboardingStatus.livenessCheck) return;
    
    // US-CA-13: Face AI Liveness Fallback (Simulated)
    if (_mounted) {
      state = state.copyWith(status: AgentOnboardingStatus.idle);
    }
  }

  Future<void> submitOnboarding(String ssmNumber) async {
    if (!_mounted) return;
    if (state.myKadNumber == null) return;
    state = state.copyWith(status: AgentOnboardingStatus.submitting, ssmNumber: ssmNumber);
    
    try {
      final response = await repository.submitOnboarding(
        mykadNumber: state.myKadNumber!,
        ssmNumber: ssmNumber,
        businessName: 'Agent ${state.myKadNumber}', 
        phoneNumber: state.phoneNumber ?? '',
      );

      if (!_mounted) return;
      if (response == null) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: 'Onboarding failed: No response');
        return;
      }

      // BDD Feature 10 S10.2: AML Flag -> Manual Review based on backend status
      if (response.status == AgentResponseStatusEnum.PENDING) {
        state = state.copyWith(status: AgentOnboardingStatus.manualReview);
      } else if (response.status == AgentResponseStatusEnum.ACTIVE) {
        state = state.copyWith(status: AgentOnboardingStatus.activated);
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.activated); // Default success
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: AgentOnboardingStatus.failed, errorMessage: e.toString());
      }
    }
  }

  void reset() {
    state = AgentOnboardingState(status: AgentOnboardingStatus.idle);
  }

  @override
  void dispose() {
    print('BDD_DEBUG: AgentOnboardingNotifier disposing...');
    _mounted = false;
    _livenessTimer?.cancel();
    super.dispose();
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
