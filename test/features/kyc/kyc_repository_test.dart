import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agent_api/agent_api.dart';
import 'package:dio/dio.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:mockito/mockito.dart';

// Concrete fake for OnboardingApi to satisfy the new repository constructor
class FakeOnboardingApi extends Mock implements OnboardingControllerOnboardingServiceApi {
  @override
  Future<Response<BuiltMap<String, JsonObject>>> verifyMyKad({
    required BuiltMap<String, String> requestBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final Map<String, dynamic> data = {};
    if (requestBody['faceMatchScore'] != null && double.parse(requestBody['faceMatchScore']!) > 0.8) {
      data['isApproved'] = true;
      data['kycId'] = 'KYC_MOCK_123';
      data['reasons'] = <String>[];
    } else if (requestBody['icNumber'] != null) {
      data['isClear'] = true;
      data['amlReference'] = 'AML_MOCK_123';
      data['isApproved'] = false;
    }

    final responseData = BuiltMap<String, JsonObject>(
      data.map((k, v) => MapEntry(k, JsonObject(v)))
    );

    return Response<BuiltMap<String, JsonObject>>(
      data: responseData,
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
    );
  }

  @override
  Future<Response<BuiltMap<String, JsonObject>>> biometricMatch({
    required BuiltMap<String, String> requestBody,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final responseData = BuiltMap<String, JsonObject>({
      'isMatched': JsonObject(true),
      'score': JsonObject(0.99),
      'matchReference': JsonObject('BIO_REF_456'),
    });

    return Response<BuiltMap<String, JsonObject>>(
      data: responseData,
      requestOptions: RequestOptions(path: ''),
      statusCode: 200,
    );
  }
}

void main() {
  late KycRepository repository;
  late FakeOnboardingApi fakeApi;

  setUp(() {
    fakeApi = FakeOnboardingApi();
    repository = KycRepository(fakeApi);
  });

  group('KycRepository', () {
    test('validateKyc returns approval for high face match score', () async {
      final request = KycValidationRequest(
        myKadData: MyKadData(
          fullName: 'TEST USER',
          icNumber: '123456-11-1234',
          address: 'ADDRESS',
        ),
        faceMatchScore: 0.95,
      );

      final response = await repository.validateKyc(request);
      expect(response.isApproved, isTrue);
      expect(response.kycId, 'KYC_MOCK_123');
    });

    test('runAmlCheck returns clear status', () async {
      final result = await repository.runAmlCheck('123456-11-1234');
      expect(result.isClear, isTrue);
      expect(result.amlReference, 'AML_MOCK_123');
    });

    test('submitBiometrics returns matched status', () async {
      final request = BiometricMatchRequest(
        icNumber: '123456-11-1234',
        biometricData: 'BASE64_DATA',
        biometricType: 'FINGERPRINT',
      );

      final response = await repository.submitBiometrics(request);
      expect(response.isMatched, isTrue);
      expect(response.score, 0.99);
      expect(response.matchReference, 'BIO_REF_456');
    });
  });
}
