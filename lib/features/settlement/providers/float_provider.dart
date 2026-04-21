import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';

final floatRepositoryProvider = Provider<FloatRepository>((ref) {
  final ledgerApi = ref.watch(ledgerApiProvider);
  return FloatRepository(ledgerApi);
});

final floatProvider = StateNotifierProvider<FloatNotifier, FloatLedger>((ref) {
  final repository = ref.watch(floatRepositoryProvider);
  // US-CA-21 fix: Use .select to only rebuild if agentId actually changes
  final agentId = ref.watch(authProvider.select((s) => s.user?.agentId));
  
  return FloatNotifier(repository, agentId);
});

class FloatNotifier extends StateNotifier<FloatLedger> {
  final FloatRepository _repository;
  final String? _agentId;
  final bool startTimer;
  bool _mounted = true;
  bool _isFetching = false;
  Timer? timer;

  FloatNotifier(this._repository, this._agentId, {this.startTimer = true}) : super(FloatLedger(
    currentBalance: Decimal.zero,
    limit: Decimal.zero,
  )) {
    // Initial fetch if authenticated
    if (_agentId != null && startTimer) {
      fetchLatestBalance();
    }
    
    if (startTimer) {
      _startPolling();
    }
  }

  void _startPolling() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (_agentId != null) {
        fetchLatestBalance();
      }
    });
  }

  Future<void> fetchLatestBalance() async {
    if (_agentId == null) return;
    if (!_mounted || _isFetching) return;
    
    _isFetching = true;
    try {
      final ledger = await _repository.getFloatStatus(_agentId!);
      if (_mounted) {
        state = ledger;
      }
    } catch (e) {
      // Handle error
    } finally {
      _isFetching = false;
    }
  }

  @override
  void dispose() {
    _mounted = false;
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
