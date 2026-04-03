import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/core/security/secure_storage_manager.dart';

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
  final SecureStorageManager? secureStorage;
  bool _mounted = true;
  bool _isInit = false;
  ComplianceNotifier({this.secureStorage}) : super(ComplianceState(isFrozen: false));

  /// Restores the frozen state from secure storage if it exists.
  /// BDD Feature 7: Compliance Enforcement persistence (FR-CA-6.3)
  Future<void> init() async {
    if (_isInit || secureStorage == null) return;
    _isInit = true;
    final isLocked = await secureStorage!.getComplianceLocked();
    if (!_mounted) return;
    if (isLocked) {
      if (_mounted) {
        state = state.copyWith(isFrozen: true, reason: 'PERSISTED_LOCK');
      }
    }
  }

  void freeze(String reason) {
    if (!_mounted) return;
    state = state.copyWith(isFrozen: true, reason: reason);
    secureStorage?.setComplianceLock(true);
  }

  void unlock() {
    if (!_mounted) return;
    state = state.copyWith(isFrozen: false, reason: 'UNLOCKED');
    secureStorage?.setComplianceLock(false);
  }

  /// Simulates a remote webhook signal from the backoffice to unlock the terminal.
  /// BDD Feature 14: Compliance Check Async Unlock (@US-CA-21).
  Future<void> simulateWebhookUnlock() async {
    if (!_mounted) return;
    await Future.delayed(const Duration(milliseconds: 100));
    if (!_mounted) return;
    unlock();
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}

final complianceProvider = StateNotifierProvider<ComplianceNotifier, ComplianceState>((ref) {
  final secureStorage = ref.watch(secureStorageManagerProvider);
  final notifier = ComplianceNotifier(secureStorage: secureStorage);
  
  // Note: Consumer needs to call notifier.init() on app startup
  return notifier;
});
