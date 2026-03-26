import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

void main() {
  late KycRepository repository;
  late Dio dio;

  setUp(() {
    dio = Dio();
    repository = KycRepository(dio);
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
      expect(response.kycId, startsWith('KYC_'));
    });

    test('runAmlCheck returns clear status', () async {
      final result = await repository.runAmlCheck('123456-11-1234');
      expect(result.isClear, isTrue);
    });
  });
}
