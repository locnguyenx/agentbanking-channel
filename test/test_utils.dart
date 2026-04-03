import 'package:mockito/mockito.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';

class ManualMockRef extends Mock implements Ref {
  @override
  T read<T>(ProviderListenable<T> provider) {
    if (provider == authProvider) {
      return AuthState(
        status: AuthStatus.authenticated,
        user: AuthUser(agentId: 'AGENT-001', name: 'Test Agent', tier: 'PREMIER'),
      ) as T;
    }
    if (provider.toString().contains('FloatNotifier') || provider.toString().contains('floatProvider')) {
       // Return a dummy float state or notifier if needed
       return FloatLedger(currentBalance: Decimal.zero, limit: Decimal.zero) as T;
    }
    throw UnimplementedError('ManualMockRef: provider $provider not mocked');
  }
}
