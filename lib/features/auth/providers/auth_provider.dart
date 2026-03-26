import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository: repository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository repository;

  AuthNotifier({required this.repository})
      : super(AuthState(status: AuthStatus.unauthenticated));

  Future<void> login(String agentId, String password) async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);
    try {
      final user = await repository.login(agentId, password);
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failed, error: e.toString());
    }
  }

  Future<void> loginBiometric() async {
    state = state.copyWith(status: AuthStatus.authenticating, error: null);
    try {
      final user = await repository.loginBiometric();
      state = state.copyWith(status: AuthStatus.authenticated, user: user);
    } catch (e) {
      state = state.copyWith(status: AuthStatus.failed, error: e.toString());
    }
  }

  void logout() {
    state = AuthState(status: AuthStatus.unauthenticated);
  }
}
