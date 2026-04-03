import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      // BDD @US-CA-22: Fetch settlement summary from backend
      // Phase 5 Enforcement: Do not use stubs for settlement logic.
      throw Exception('Backend API mapping required for settlement summary');
    } catch (e) {
      state = state.copyWith(status: SettlementStatus.error, error: e.toString());
    }
  }

  Future<void> performSettlement() async {
    state = state.copyWith(status: SettlementStatus.processing);
    try {
      // BDD @US-CA-22: Execute EOD closure
      // Phase 5 Enforcement: Do not use stubs for settlement logic.
      throw Exception('Backend API mapping required for EOD closure');
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
