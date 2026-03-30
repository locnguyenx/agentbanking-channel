import 'package:dio/dio.dart';
import 'package:agent_api/agent_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';

class KycRepository {
  final OnboardingControllerOnboardingServiceApi onboardingApi;
  final Dio _dio;

  KycRepository(this.onboardingApi, this._dio);

  Future<KycValidationResponse> validateKyc(KycValidationRequest request) async {
    final myKadVerifyRequest = MyKadVerifyRequest((b) => b
      ..mykadNumber = request.myKadData.icNumber
      ..name = request.myKadData.fullName
      ..address = request.myKadData.address
    );

    final response = await onboardingApi.verifyMyKad(myKadVerifyRequest: myKadVerifyRequest);
    final data = response.data;

    return KycValidationResponse(
      isApproved: data?.status == KycVerifyResponseStatusEnum.VERIFIED,
      kycId: data?.verificationId,
      reasons: [],
    );
  }

  Future<AmlCheckResponse> runAmlCheck(String icNumber) async {
    final myKadVerifyRequest = MyKadVerifyRequest((b) => b
      ..mykadNumber = icNumber
      ..name = 'SYSTEM_AML_CHECK'
    );

    final response = await onboardingApi.verifyMyKad(myKadVerifyRequest: myKadVerifyRequest);
    final data = response.data;

    return AmlCheckResponse(
      isClear: data?.status == KycVerifyResponseStatusEnum.VERIFIED,
      amlReference: data?.verificationId,
    );
  }

  Future<BiometricMatchResponse> submitBiometrics(BiometricMatchRequest request) async {
    final requestBody = BuiltMap<String, String>({
      'icNumber': request.icNumber,
      'biometricData': request.biometricData,
      'biometricType': request.biometricType,
    });

    final response = await onboardingApi.biometricMatch(requestBody: requestBody);
    final data = response.data;

    final isMatched = data?['isMatched']?.value as bool? ?? false;
    final score = double.tryParse(data?['score']?.value.toString() ?? '0.0') ?? 0.0;
    final matchReference = data?['matchReference']?.value as String?;

    return BiometricMatchResponse(
      isMatched: isMatched,
      score: score,
      matchReference: matchReference,
    );
  }

  Future<void> openAccount(String icNumber, String productCode) async {
    // Phase 2 Fix: Call real Gateway Onboarding service for account opening.
    // We use _dio directly because the endpoint is missing from the current spec.
    await _dio.post('/api/v1/onboarding/open-account', data: {
      'icNumber': icNumber,
      'productCode': productCode,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }
}
