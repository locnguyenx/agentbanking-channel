import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

enum AgentOnboardingStatus { idle, scanning, submitting, activated, manualReview, failed }

class AgentOnboardingState {
  final AgentOnboardingStatus status;
  final String? myKadNumber;
  final String? ssmNumber;
  final String? errorMessage;

  AgentOnboardingState({
    required this.status,
    this.myKadNumber,
    this.ssmNumber,
    this.errorMessage,
  });

  AgentOnboardingState copyWith({
    AgentOnboardingStatus? status,
    String? myKadNumber,
    String? ssmNumber,
    String? errorMessage,
  }) {
    return AgentOnboardingState(
      status: status ?? this.status,
      myKadNumber: myKadNumber ?? this.myKadNumber,
      ssmNumber: ssmNumber ?? this.ssmNumber,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AgentOnboardingNotifier extends StateNotifier<AgentOnboardingState> {
  final IMyKadScanner myKadScanner;

  AgentOnboardingNotifier({required this.myKadScanner}) 
    : super(AgentOnboardingState(status: AgentOnboardingStatus.idle));

  Future<void> scanMyKad() async {
    state = state.copyWith(status: AgentOnboardingStatus.scanning);
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

  Future<void> submitOnboarding(String ssmNumber) async {
    if (state.myKadNumber == null) return;
    state = state.copyWith(status: AgentOnboardingStatus.submitting, ssmNumber: ssmNumber);
    
    try {
      // Simulate backend KYC / STP (Straight-Through Processing)
      await Future.delayed(const Duration(seconds: 2));
      
      // BDD Feature 10 S10.1: Instant Activation
      // S10.2: AML Flag -> Manual Review
      if (ssmNumber.startsWith('AML')) {
        state = state.copyWith(status: AgentOnboardingStatus.manualReview);
      } else {
        state = state.copyWith(status: AgentOnboardingStatus.activated);
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
  // In a real app, IMyKadScanner would be provided by a global hardware provider
  // For now we assume one is accessible or injected.
  throw UnimplementedError('Provide hardware dependency via ref');
});
