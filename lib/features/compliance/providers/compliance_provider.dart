import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

class ComplianceState {
  final bool isFrozen;
  final String? reason;

  ComplianceState({required this.isFrozen, this.reason});

  ComplianceState copyWith({bool? isFrozen, String? reason}) {
    return ComplianceState(
      isFrozen: isFrozen ?? this.isFrozen,
      reason: reason ?? this.reason,
    );
  }
}

class ComplianceNotifier extends StateNotifier<ComplianceState> {
  ComplianceNotifier() : super(ComplianceState(isFrozen: false));

  void freeze(String reason) {
    state = state.copyWith(isFrozen: true, reason: reason);
  }

  void unlock() {
    state = state.copyWith(isFrozen: false, reason: null);
  }

  /// Simulates a remote webhook signal from the backoffice to unlock the terminal.
  /// BDD Feature 14: Compliance Check Async Unlock.
  Future<void> simulateWebhookUnlock() async {
    // Delay simulate network latency
    await Future.delayed(const Duration(seconds: 3));
    unlock();
  }
}

final complianceProvider = StateNotifierProvider<ComplianceNotifier, ComplianceState>((ref) {
  return ComplianceNotifier();
});
