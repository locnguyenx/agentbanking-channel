
enum AuthStatus {
  unauthenticated,
  authenticating,
  authenticated,
  failed,
  expired,
}

class AuthUser {
  final String agentId;
  final String name;
  final String tier;
  final double? registeredLat;
  final double? registeredLng;

  AuthUser({
    required this.agentId,
    required this.name,
    required this.tier,
    this.registeredLat,
    this.registeredLng,
  });

  AuthUser copyWith({
    String? agentId,
    String? name,
    String? tier,
    double? registeredLat,
    double? registeredLng,
  }) {
    return AuthUser(
      agentId: agentId ?? this.agentId,
      name: name ?? this.name,
      tier: tier ?? this.tier,
      registeredLat: registeredLat ?? this.registeredLat,
      registeredLng: registeredLng ?? this.registeredLng,
    );
  }
}

class AuthState {
  final AuthStatus status;
  final AuthUser? user;
  final String? error;

  AuthState({
    required this.status,
    this.user,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }
}
