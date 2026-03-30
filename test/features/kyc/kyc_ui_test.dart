import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agent_api/agent_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/kyc/screens/kyc_flow_screen.dart';
import 'package:agentbanking_channel/features/kyc/providers/onboarding_provider.dart';

import 'package:dio/dio.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/features/kyc/models/kyc_models.dart';
import 'package:agentbanking_channel/features/kyc/repositories/kyc_repository.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

class DummyKycRepository implements KycRepository {
  @override
  OnboardingControllerOnboardingServiceApi get onboardingApi => throw UnimplementedError();
  @override
  Future<KycValidationResponse> validateKyc(KycValidationRequest request) async => throw UnimplementedError();
  @override
  Future<AmlCheckResponse> runAmlCheck(String icNumber) async => throw UnimplementedError();
}

class DummyScanner implements IMyKadScanner {
  @override
  Future<MyKadData?> scanMyKad() async => null;
  @override
  Future<bool> isAvailable() async => true;
}

// Mock Notifier
class MockOnboardingNotifier extends OnboardingNotifier {
  MockOnboardingNotifier() : super(
    kycRepository: DummyKycRepository(),
    myKadScanner: DummyScanner(),
  );
}

void main() {
  testWidgets('renders start scan button in idle state', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          onboardingProvider.overrideWith((ref) => MockOnboardingNotifier()),
          pendingQueueCountProvider.overrideWith((ref) => const Stream.empty()),
        ],
        child: const MaterialApp(home: KycFlowScreen()),
      ),
    );

    await tester.pump(); // Allow state to propagate
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('START MYKAD SCAN'), findsOneWidget);
  });
}
