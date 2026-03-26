import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';

class MockKycRepository extends Mock implements KycRepository {}
class MockMyKadScanner extends Mock implements IMyKadScanner {}

void main() {
  late OnboardingNotifier notifier;
  late MockKycRepository repository;
  late MockMyKadScanner scanner;

  setUp(() {
    repository = MockKycRepository();
    scanner = MockMyKadScanner();
    notifier = OnboardingNotifier(kycRepository: repository, myKadScanner: scanner);
  });

  group('OnboardingNotifier State Machine', () {
    test('initial state is idle', () {
      expect(notifier.state.status, OnboardingStatus.idle);
    });

    test('reset() clears state', () {
      notifier.reset();
      expect(notifier.state.status, OnboardingStatus.idle);
      expect(notifier.state.myKadData, isNull);
    });
  });
}
