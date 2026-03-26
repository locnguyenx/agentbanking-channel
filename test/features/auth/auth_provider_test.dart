import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/auth/models/auth_models.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/auth/repositories/auth_repository.dart';

void main() {
  late AuthNotifier auth;
  late AuthRepository repository;

  setUp(() {
    repository = AuthRepository();
    auth = AuthNotifier(repository: repository);
  });

  test('initial state is unauthenticated', () {
    expect(auth.state.status, AuthStatus.unauthenticated);
    expect(auth.state.user, isNull);
  });

  test('login updates state to authenticated with valid credentials', () async {
    await auth.login('AGENT01', '123456');
    expect(auth.state.status, AuthStatus.authenticated);
    expect(auth.state.user?.agentId, 'AGENT01');
  });

  test('login updates state to failed with invalid credentials', () async {
    await auth.login('AGENT01', 'wrong-pass');
    expect(auth.state.status, AuthStatus.failed);
    expect(auth.state.error, contains('Exception: Invalid Agent ID or Password'));
  });

  test('logout resets state to unauthenticated', () async {
    await auth.login('AGENT01', '123456');
    auth.logout();
    expect(auth.state.status, AuthStatus.unauthenticated);
    expect(auth.state.user, isNull);
  });

  test('loginBiometric updates state to authenticated', () async {
    await auth.loginBiometric();
    expect(auth.state.status, AuthStatus.authenticated);
    expect(auth.state.user?.agentId, 'AGENT_BIO_01');
  });
}
