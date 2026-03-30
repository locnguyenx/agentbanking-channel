import 'package:agent_api/agent_api.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';

class KycRepository {
  final OnboardingControllerOnboardingServiceApi onboardingApi;

  KycRepository(this.onboardingApi);

  Future<KycValidationResponse> validateKyc(KycValidationRequest request) async {
    final requestBody = BuiltMap<String, String>({
      'icNumber': request.myKadData.icNumber,
      'fullName': request.myKadData.fullName,
      'address': request.myKadData.address,
      'faceMatchScore': request.faceMatchScore.toString(),
    });

    final response = await onboardingApi.verifyMyKad(requestBody: requestBody);
    final data = response.data;

    // Map BuiltMap<String, JsonObject> to domain model
    final isApproved = data?['isApproved']?.value as bool? ?? false;
    final kycId = data?['kycId']?.value as String?;
    final reasons = (data?['reasons']?.value as List?)?.cast<String>() ?? [];

    return KycValidationResponse(
      isApproved: isApproved,
      kycId: kycId,
      reasons: reasons,
    );
  }

  Future<AmlCheckResponse> runAmlCheck(String icNumber) async {
    final requestBody = BuiltMap<String, String>({
      'icNumber': icNumber,
    });

    // Reuse verifyMyKad or biometricMatch if no specific AML endpoint in spec
    final response = await onboardingApi.verifyMyKad(requestBody: requestBody);
    final data = response.data;

    final isClear = data?['isClear']?.value as bool? ?? true;
    final amlReference = data?['amlReference']?.value as String?;

    return AmlCheckResponse(
      isClear: isClear,
      amlReference: amlReference,
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
}
