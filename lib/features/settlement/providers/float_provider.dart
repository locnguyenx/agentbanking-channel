import 'package:decimal/decimal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';

final floatProvider = StateNotifierProvider<FloatNotifier, FloatLedger>((ref) {
  return FloatNotifier();
});

class FloatNotifier extends StateNotifier<FloatLedger> {
  FloatNotifier() : super(FloatLedger(
    currentBalance: Decimal.parse('5000.0'),
    limit: Decimal.parse('10000.0'),
  ));

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
