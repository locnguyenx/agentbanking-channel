import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';
import 'package:agentbanking_channel/features/settlement/repositories/float_repository.dart';

final floatRepositoryProvider = Provider<FloatRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return FloatRepository(dio);
});

final floatProvider = StateNotifierProvider<FloatNotifier, FloatLedger>((ref) {
  final repository = ref.watch(floatRepositoryProvider);
  return FloatNotifier(repository);
});

class FloatNotifier extends StateNotifier<FloatLedger> {
  final FloatRepository _repository;

  FloatNotifier(this._repository) : super(FloatLedger(
    currentBalance: Decimal.parse('5000.0'),
    limit: Decimal.parse('10000.0'),
  ));

  Future<void> fetchLatestBalance() async {
    try {
      final ledger = await _repository.getFloatStatus();
      state = ledger;
    } catch (e) {
      // Handle error
    }
  }

  /// Credits float (Increases balance), e.g. on Cash Withdrawal
  void creditFloat(Decimal amount, String transactionId) {
    final entry = FloatEntry(
      id: 'FE_${DateTime.now().millisecondsSinceEpoch}',
      transactionId: transactionId,
      amount: amount,
      type: FloatEntryType.CREDIT,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      currentBalance: state.currentBalance + amount,
      entries: [...state.entries, entry],
    );
  }

  /// Debits float (Decreases balance), e.g. on Cash-In / Bill Payment
  void debitFloat(Decimal amount, String transactionId) {
    final entry = FloatEntry(
      id: 'FE_${DateTime.now().millisecondsSinceEpoch}',
      transactionId: transactionId,
      amount: amount,
      type: FloatEntryType.DEBIT,
      timestamp: DateTime.now(),
    );
    state = state.copyWith(
      currentBalance: state.currentBalance - amount,
      entries: [...state.entries, entry],
    );
  }
}
