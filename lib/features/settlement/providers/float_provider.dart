import 'dart:async';
import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';

final floatRepositoryProvider = Provider<FloatRepository>((ref) {
  final ledgerApi = ref.watch(ledgerApiProvider);
  return FloatRepository(ledgerApi);
});

final floatProvider = StateNotifierProvider<FloatNotifier, FloatLedger>((ref) {
  final repository = ref.watch(floatRepositoryProvider);
  final notifier = FloatNotifier(repository);
  
  // Start polling
  final timer = Timer.periodic(const Duration(seconds: 30), (_) {
    notifier.fetchLatestBalance();
  });
  
  ref.onDispose(() => timer.cancel());
  
  return notifier;
});

class FloatNotifier extends StateNotifier<FloatLedger> {
  final FloatRepository _repository;

  FloatNotifier(this._repository) : super(FloatLedger(
    currentBalance: Decimal.parse('5000.0'),
    limit: Decimal.parse('10000.0'),
  )) {
    // Initial fetch
    fetchLatestBalance();
  }

  Future<void> fetchLatestBalance() async {
    try {
      final ledger = await _repository.getFloatStatus();
      state = ledger;
    } catch (e) {
      // Handle error
    }
  }
}
