import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/hardware_providers.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';

enum OnboardingStatus {
  idle,
  scanningMyKad,
  validatingKyc,
  livenessProcessing,
  selectingProduct,
  provisioning,
  success,
  manualReview,
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
  bool _mounted = true;

  OnboardingNotifier({
    required this.kycRepository,
    required this.myKadScanner,
  }) : super(OnboardingState(status: OnboardingStatus.idle));

  Future<void> startOnboarding() async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: OnboardingStatus.scanningMyKad, error: null);
    }
    try {
      final myKadData = await myKadScanner.scanMyKad();
      if (!_mounted) return;
      if (myKadData == null) {
        if (_mounted) {
          state = state.copyWith(status: OnboardingStatus.failed, error: 'MyKad Scan Failed');
        }
        return;
      }
      
      if (_mounted) {
        state = state.copyWith(status: OnboardingStatus.validatingKyc, myKadData: myKadData);
      }
      
      // Perform KYC validation (Face score mock: 0.9)
      final kycResponse = await kycRepository.validateKyc(KycValidationRequest(
        myKadData: myKadData,
        faceMatchScore: 0.9,
      ));

      if (!_mounted) return;
      if (kycResponse.isApproved) {
        if (_mounted) {
          state = state.copyWith(status: OnboardingStatus.selectingProduct, kycResponse: kycResponse);
        }
      } else if (kycResponse.reasons.contains('MANUAL_REVIEW')) {
        if (_mounted) {
          state = state.copyWith(status: OnboardingStatus.manualReview, kycResponse: kycResponse);
        }
      } else {
        if (_mounted) {
          state = state.copyWith(status: OnboardingStatus.failed, error: kycResponse.reasons.join(', '));
        }
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: OnboardingStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> selectProduct(String productCode) async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: OnboardingStatus.provisioning, selectedProduct: productCode);
    }
    try {
      await kycRepository.openAccount(state.myKadData?.icNumber ?? '', productCode);
      if (_mounted) {
        state = state.copyWith(status: OnboardingStatus.success);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: OnboardingStatus.failed, error: e.toString());
      }
    }
  }

  void reset() {
    state = OnboardingState(status: OnboardingStatus.idle);
  }

  void debugSetState(OnboardingState newState) {
    state = newState;
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}

final kycRepositoryProvider = Provider<KycRepository>((ref) {
  return KycRepository(
    ref.watch(onboardingApiProvider),
    ref.watch(dioProvider),
  );
});

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final repository = ref.watch(kycRepositoryProvider);
  final myKadScanner = ref.watch(myKadScannerProvider);
  return OnboardingNotifier(
    kycRepository: repository,
    myKadScanner: myKadScanner,
  );
});
