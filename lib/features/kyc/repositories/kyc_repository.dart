import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';

class KycRepository {
  final Dio dio;

  KycRepository(this.dio);

  Future<KycValidationResponse> validateKyc(KycValidationRequest request) async {
    // Simulated API call to /api/v1/kyc/validate
    await Future.delayed(const Duration(seconds: 1));
    
    // Auto-approve if faceMatchScore > 0.8 for mock
    if (request.faceMatchScore > 0.8) {
      return KycValidationResponse(
        isApproved: true,
        kycId: 'KYC_${DateTime.now().millisecondsSinceEpoch}',
        reasons: [],
      );
    } else {
      return KycValidationResponse(
        isApproved: false,
        reasons: ['FACE_MATCH_LOW'],
      );
    }
  }

  Future<AmlCheckResponse> runAmlCheck(String icNumber) async {
    // Simulated API call to /api/v1/kyc/aml-check
    await Future.delayed(const Duration(milliseconds: 500));
    
    return AmlCheckResponse(
      isClear: true,
      amlReference: 'AML_REF_${DateTime.now().millisecondsSinceEpoch}',
    );
  }
}
