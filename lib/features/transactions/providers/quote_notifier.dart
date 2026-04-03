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
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

/// Handles the initial quote phase of any transaction:
///   idle → quoting → waitingConsent (or failed)
///
/// Deps: TransactionRepository, GeolocatorPlatform (+ reads auth/compliance/eod from Ref)
class QuoteNotifier extends StateNotifier<TransactionState> {
  final Ref ref;
  final TransactionRepository repository;
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

    // --- Guard checks (compliance, EOD, geofence) ---
    final complianceState = ref.read(complianceProvider);
    if (complianceState.isFrozen) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_COMPLIANCE_FROZEN');
      return;
    }

    final eodService = ref.read(eodTimerServiceProvider.notifier);
    if (eodService.getCurrentEodStatus() == EodStatus.locked) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_EOD_LOCKED');
      return;
    }

    final authUser = ref.read(authProvider).user;
    if (authUser?.registeredLat != null && authUser?.registeredLng != null) {
      try {
        final position = await geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        if (!_mounted) return;
        final geofence = GeofenceService(shopLat: authUser!.registeredLat!, shopLng: authUser.registeredLng!);
        if (!geofence.isWithinGeofence(position.latitude, position.longitude)) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_GEOFENCE_BREACH');
          return;
        }
      } catch (e) {
        if (_mounted) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_GPS_UNAVAILABLE');
        }
        return;
      }
    }

    if (!_mounted) return;

    // --- Input validation ---
    final phone = metadata?['mobileNumber'] ?? metadata?['mobile'] ?? metadata?['identifier'] ?? '';
    bool shouldValidatePhone = serviceCode.contains('TOP_UP') || serviceCode == 'ESSP' || serviceCode == 'PIN_PURCHASE';
    if (shouldValidatePhone && phone.isNotEmpty) {
      bool isTopUpPrefix = phone.startsWith('01');
      bool isExplicitTopUp = serviceCode.contains('TOP_UP');
      if (isTopUpPrefix || isExplicitTopUp) {
        if (!ValidationService.isValidPhoneNumber(phone)) {
          state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_VAL_INVALID_PHONE_FORMAT');
          return;
        }
      }
    }

    if (amount > Decimal.fromInt(5000)) {
      state = state.copyWith(status: TransactionStatus.failed, error: 'ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 5,000 per transaction');
      return;
    }

    if (fundingSource == FundingSource.CASH && amount > Decimal.fromInt(3000)) {
      state = state.copyWith(
        status: TransactionStatus.waitingMyKadScan,
        amount: amount,
        serviceCode: serviceCode,
        fundingSource: fundingSource,
        metadata: metadata,
        error: 'ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM 3,000 per STP transaction',
      );
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
