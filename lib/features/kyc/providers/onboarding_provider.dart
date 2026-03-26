import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

enum OnboardingStatus {
  idle,
  scanningMyKad,
  validatingKyc,
  selectingProduct,
  provisioning,
  success,
  failed,
}

class OnboardingState {
  final OnboardingStatus status;
  final MyKadData? myKadData;
  final KycValidationResponse? kycResponse;
  final String? selectedProduct;
  final String? error;

  OnboardingState({
    required this.status,
    this.myKadData,
    this.kycResponse,
    this.selectedProduct,
    this.error,
  });

  OnboardingState copyWith({
    OnboardingStatus? status,
    MyKadData? myKadData,
    KycValidationResponse? kycResponse,
    String? selectedProduct,
    String? error,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      myKadData: myKadData ?? this.myKadData,
      kycResponse: kycResponse ?? this.kycResponse,
      selectedProduct: selectedProduct ?? this.selectedProduct,
      error: error ?? this.error,
    );
  }
}

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final KycRepository kycRepository;
  final IMyKadScanner myKadScanner;

  OnboardingNotifier({
    required this.kycRepository,
    required this.myKadScanner,
  }) : super(OnboardingState(status: OnboardingStatus.idle));

  Future<void> startOnboarding() async {
    state = state.copyWith(status: OnboardingStatus.scanningMyKad, error: null);
    try {
      final myKadData = await myKadScanner.scanMyKad();
      if (myKadData == null) {
        state = state.copyWith(status: OnboardingStatus.failed, error: 'MyKad Scan Failed');
        return;
      }
      
      state = state.copyWith(status: OnboardingStatus.validatingKyc, myKadData: myKadData);
      
      // Perform KYC validation (Face score mock: 0.9)
      final kycResponse = await kycRepository.validateKyc(KycValidationRequest(
        myKadData: myKadData,
        faceMatchScore: 0.9,
      ));

      if (kycResponse.isApproved) {
        state = state.copyWith(status: OnboardingStatus.selectingProduct, kycResponse: kycResponse);
      } else {
        state = state.copyWith(status: OnboardingStatus.failed, error: kycResponse.reasons.join(', '));
      }
    } catch (e) {
      state = state.copyWith(status: OnboardingStatus.failed, error: e.toString());
    }
  }

  void selectProduct(String productCode) {
    state = state.copyWith(status: OnboardingStatus.provisioning, selectedProduct: productCode);
    // In real app, call Provisioning API here
    Future.delayed(const Duration(seconds: 2), () {
      state = state.copyWith(status: OnboardingStatus.success);
    });
  }

  void reset() {
    state = OnboardingState(status: OnboardingStatus.idle);
  }
}

final kycRepositoryProvider = Provider<KycRepository>((ref) => KycRepository(Dio()));

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final repository = ref.watch(kycRepositoryProvider);
  return OnboardingNotifier(
    kycRepository: repository,
    myKadScanner: MockMyKadScanner(),
  );
});
