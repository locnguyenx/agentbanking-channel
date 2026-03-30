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
  Future<Response<KycVerifyResponse>> verifyMyKad({
    required MyKadVerifyRequest myKadVerifyRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final status = (myKadVerifyRequest.name == 'TEST USER' || myKadVerifyRequest.name == 'SYSTEM_AML_CHECK')
        ? KycVerifyResponseStatusEnum.VERIFIED 
        : KycVerifyResponseStatusEnum.PENDING;

    final responseData = KycVerifyResponse((b) => b
      ..status = status
      ..verificationId = myKadVerifyRequest.name == 'SYSTEM_AML_CHECK' ? 'AML_MOCK_123' : 'KYC_MOCK_123'
      ..message = 'Success'
    );

    return Response<KycVerifyResponse>(
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

class MockDio extends Mock implements Dio {
  @override
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return Response(
      requestOptions: RequestOptions(path: path),
      data: {'status': 'SUCCESS'} as T,
      statusCode: 200,
    );
  }
}

void main() {
  late KycRepository repository;
  late FakeOnboardingApi fakeApi;
  late MockDio mockDio;

  setUp(() {
    fakeApi = FakeOnboardingApi();
    mockDio = MockDio();
    repository = KycRepository(fakeApi, mockDio);
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
