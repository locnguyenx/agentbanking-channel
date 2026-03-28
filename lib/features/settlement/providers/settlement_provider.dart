import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/settlement/models/settlement_models.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

enum SettlementStatus { idle, loading, ready, processing, settled, error }

class SettlementState {
  final SettlementStatus status;
  final SettlementSummary? summary;
  final String? error;
  final SettlementClosureResponse? result;

  SettlementState({
    required this.status,
    this.summary,
    this.error,
    this.result,
  });

  SettlementState copyWith({
    SettlementStatus? status,
    SettlementSummary? summary,
    String? error,
    SettlementClosureResponse? result,
  }) {
    return SettlementState(
      status: status ?? this.status,
      summary: summary ?? this.summary,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }
}

class SettlementNotifier extends StateNotifier<SettlementState> {
  final TransactionRepository repository;

  SettlementNotifier({required this.repository}) : super(SettlementState(status: SettlementStatus.idle));

  Future<void> fetchSummary() async {
    state = state.copyWith(status: SettlementStatus.loading);
    try {
      // Simulate backend aggregation API
      await Future.delayed(const Duration(seconds: 1));
      
      final summary = SettlementSummary(
        terminalId: 'TM-001',
        timestamp: DateTime.now(),
        services: [
          ServiceTotal(serviceName: 'Bill Payment', count: 12, totalAmount: Decimal.parse('1250.00'), totalCommission: Decimal.parse('6.00')),
          ServiceTotal(serviceName: 'DuitNow Trf', count: 5, totalAmount: Decimal.parse('3000.00'), totalCommission: Decimal.parse('2.50')),
          ServiceTotal(serviceName: 'Merchant Sale', count: 8, totalAmount: Decimal.parse('850.50'), totalCommission: Decimal.parse('8.50')),
        ],
        netVolume: Decimal.parse('5100.50'),
        totalCommission: Decimal.parse('17.00'),
      );
      
      state = state.copyWith(status: SettlementStatus.ready, summary: summary);
    } catch (e) {
      state = state.copyWith(status: SettlementStatus.error, error: e.toString());
    }
  }

  Future<void> performSettlement() async {
    if (state.summary == null) return;
    state = state.copyWith(status: SettlementStatus.processing);
    try {
      // Simulate EOD Closure API
      await Future.delayed(const Duration(seconds: 2));
      
      final result = SettlementClosureResponse(
        success: true,
        batchNumber: 'B-${DateTime.now().day}${DateTime.now().hour}',
        reference: 'SETTLE-${DateTime.now().millisecondsSinceEpoch}',
      );
      
      state = state.copyWith(status: SettlementStatus.settled, result: result);
    } catch (e) {
      state = state.copyWith(status: SettlementStatus.error, error: e.toString());
    }
  }

  void reset() {
    state = SettlementState(status: SettlementStatus.idle);
  }
}

final settlementProvider = StateNotifierProvider<SettlementNotifier, SettlementState>((ref) {
  final repository = ref.watch(transactionRepositoryProvider);
  return SettlementNotifier(repository: repository);
});
