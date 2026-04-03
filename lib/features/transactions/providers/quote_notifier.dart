import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uuid/uuid.dart';

import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_guards.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

/// Handles the initial quote phase of any transaction:
///   idle → quoting → waitingConsent (or failed)
///
/// Deps: TransactionRepository, GeolocatorPlatform (+ reads auth/compliance/eod from Ref)
class QuoteNotifier extends StateNotifier<TransactionState> with TransactionGuardMixin {
  @override
  final Ref ref;
  final TransactionRepository repository;
  @override
  final GeolocatorPlatform geolocator;
  bool _mounted = true;

  QuoteNotifier({
    required this.ref,
    required this.repository,
    required this.geolocator,
  }) : super(TransactionState(status: TransactionStatus.idle));

  /// Validate inputs and get a quote from the backend.
  /// Returns the resulting state (callers can check quote/status).
  Future<void> startQuote(
    Decimal amount,
    String merchantId, {
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    if (!_mounted) return;

    // Universal AML Check: For Cash >= 3000 (Soft Cap)
    if (fundingSource == FundingSource.CASH && amount >= Decimal.fromInt(3000)) {
      state = state.copyWith(
        status: TransactionStatus.waitingMyKadScan,
        amount: amount,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
      );
      return;
    }

    final guardError = await performGuards(
      amount: amount,
      serviceCode: serviceCode,
      fundingSource: fundingSource,
      metadata: metadata,
    );
    if (guardError != null) {
      state = state.copyWith(status: TransactionStatus.failed, error: guardError);
      return;
    }

    final idempotencyKey = Uuid().v4();
    state = TransactionState(
      status: TransactionStatus.quoting,
      amount: amount,
      serviceCode: serviceCode,
      fundingSource: fundingSource,
      metadata: metadata,
      idempotencyKey: idempotencyKey,
    );

    try {
      final quote = await repository.getQuote(TransactionQuoteRequest(
        serviceCode: serviceCode,
        amount: amount,
        agentId: merchantId,
        fundingSource: fundingSource,
      ));
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.waitingConsent, quote: quote);
      }
    } catch (e) {
      if (_mounted) {
        state = state.copyWith(status: TransactionStatus.failed, error: e.toString());
      }
    }
  }

  void reset() {
    state = TransactionState(status: TransactionStatus.idle);
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }
}

final quoteNotifierProvider = StateNotifierProvider<QuoteNotifier, TransactionState>((ref) {
  return QuoteNotifier(
    ref: ref,
    repository: ref.watch(transactionRepositoryProvider),
    geolocator: GeolocatorPlatform.instance,
  );
});
