import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final secureStorage = ref.watch(secureStorageManagerProvider);
  return AuthRepository(secureStorage: secureStorage);
});

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository: repository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;
  bool _mounted = true;

  AuthNotifier({required this.repository})
      : super(AuthState(status: AuthStatus.unauthenticated));

  Future<void> login(String agentId, String password) async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: AuthStatus.authenticating, error: null);
    }
    
    final isWhitelisted = repository.isDeviceWhitelisted;
    if (!isWhitelisted) {
      if (_mounted) {
        state = state.copyWith(status: AuthStatus.failed, error: 'ERR_AUTH_DEVICE_NOT_WHITELISTED');
      }
        return;
    }

    try {
      final user = await repository.login(agentId, password);
      
      if (!_mounted) return;
      if (_mounted) {
        state = AuthState(user: user, status: AuthStatus.authenticated);
      }
    } catch (e) {
      if (_mounted) {
        state = AuthState(status: AuthStatus.failed, error: e.toString());
      }
    }
  }

  Future<void> loginBiometric() async {
    if (!_mounted) return;
    if (_mounted) {
      state = state.copyWith(status: AuthStatus.authenticating, error: null);
    }

    final isWhitelisted = repository.isDeviceWhitelisted;
    if (!isWhitelisted) {
      if (_mounted) {
        state = state.copyWith(status: AuthStatus.failed, error: 'ERR_AUTH_DEVICE_NOT_WHITELISTED');
      }
        return;
    }

    try {
      final user = await repository.loginBiometric();
        if (_mounted) {
        state = state.copyWith(status: AuthStatus.authenticated, user: user);
      }
    } catch (e) {
        if (_mounted) {
        state = state.copyWith(status: AuthStatus.failed, error: e.toString());
      }
    }
  }

  void logout() {
    repository.secureStorage.clearJwt();
    state = AuthState(status: AuthStatus.unauthenticated);
  }

  void debugTriggerSessionExpired() {
    state = state.copyWith(status: AuthStatus.expired);
  }

  void debugSetAuthenticated(AuthUser user) {
    state = state.copyWith(status: AuthStatus.authenticated, user: user);
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}
