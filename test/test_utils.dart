import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/features/settlement/providers/float_provider.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'setup/test_credentials.dart';

class ManualMockRef extends Mock implements Ref {
  ComplianceState? complianceOverride;

  @override
  T read<T>(ProviderListenable<T> provider) {
    if (provider == authProvider) {
      return AuthState(
        status: AuthStatus.authenticated,
        user: AuthUser(agentId: TestCredentials.username, name: 'Test Agent', tier: 'PREMIER'),
      ) as T;
    }
    if (provider == complianceProvider) {
      return (complianceOverride ?? ComplianceState(isFrozen: false)) as T;
    }
    if (provider == eodTimerServiceProvider.notifier) {
      // Return a dummy EOD service
      return FakeEodTimerService(locked: false) as T;
    }
    if (provider == floatProvider) {
      return FloatLedger(currentBalance: Decimal.zero, limit: Decimal.zero) as T;
    }
    if (provider.toString().contains('FloatNotifier') || provider.toString().contains('floatProvider')) {
       return FloatLedger(currentBalance: Decimal.zero, limit: Decimal.zero) as T;
    }
    throw UnimplementedError('ManualMockRef: provider $provider not mocked');
  }
}

class FakeEodTimerService extends Mock implements EodTimerService {
  final bool locked;
  FakeEodTimerService({this.locked = false});
  @override
  bool get isLocked => locked;

  @override
  EodStatus getCurrentEodStatus() => locked ? EodStatus.locked : EodStatus.open;
}
