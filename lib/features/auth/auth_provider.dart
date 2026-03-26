enum AuthState { unauthenticated, authenticated }

class AuthNotifier {
  AuthState state = AuthState.unauthenticated;
  
  void login(String jwt) {
    state = AuthState.authenticated;
  }
  
  void logout() {
    state = AuthState.unauthenticated;
  }
}
