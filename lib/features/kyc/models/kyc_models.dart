import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

class KycValidationRequest {
  final MyKadData myKadData;
  final double faceMatchScore;

  KycValidationRequest({
    required this.myKadData,
    required this.faceMatchScore,
  });

  Map<String, dynamic> toJson() => {
    'fullName': myKadData.fullName,
    'icNumber': myKadData.icNumber,
    'address': myKadData.address,
    'faceMatchScore': faceMatchScore,
  };
}

class KycValidationResponse {
  final bool isApproved;
  final String? kycId;
  final List<String> reasons;

  KycValidationResponse({
    required this.isApproved,
    this.kycId,
    required this.reasons,
  });

  factory KycValidationResponse.fromJson(Map<String, dynamic> json) =>
      KycValidationResponse(
        isApproved: json['isApproved'],
        kycId: json['kycId'],
        reasons: List<String>.from(json['reasons'] ?? []),
      );
}

class AmlCheckResponse {
  final bool isClear;
  final String? amlReference;

  AmlCheckResponse({required this.isClear, this.amlReference});

  factory AmlCheckResponse.fromJson(Map<String, dynamic> json) =>
      AmlCheckResponse(
        isClear: json['isClear'],
        amlReference: json['amlReference'],
      );
}

class BiometricMatchRequest {
  final String icNumber;
  final String biometricData;
  final String biometricType; // 'FINGERPRINT' or 'FACE'

  BiometricMatchRequest({
    required this.icNumber,
    required this.biometricData,
    required this.biometricType,
  });
}

class BiometricMatchResponse {
  final bool isMatched;
  final double score;
  final String? matchReference;

  BiometricMatchResponse({
    required this.isMatched,
    required this.score,
    this.matchReference,
  });
}
