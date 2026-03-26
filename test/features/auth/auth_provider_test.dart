import 'package:flutter_test/flutter_test.dart';
import '../../lib/features/auth/auth_provider.dart';

void main() {
  test('AuthNotifier correctly transitions login and logout states', () {
    final auth = AuthNotifier();
    expect(auth.state, AuthState.unauthenticated);
    
    auth.login('mock-jwt');
    expect(auth.state, AuthState.authenticated);
    
    auth.logout();
    expect(auth.state, AuthState.unauthenticated);
  });
}
