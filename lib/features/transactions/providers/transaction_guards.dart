import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:decimal/decimal.dart';

import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_state.dart';
import 'package:agentbanking_channel/features/transactions/services/validation_service.dart';
import 'package:agentbanking_channel/features/auth/providers/auth_provider.dart';
import 'package:agentbanking_channel/features/compliance/providers/compliance_provider.dart';
import 'package:agentbanking_channel/features/settlement/services/eod_timer_service.dart';
import 'package:agentbanking_channel/core/location/geofence_service.dart';

/// Mixin providing universal 5-tier pre-checks and validation
/// for all transaction sub-notifiers.
mixin TransactionGuardMixin on StateNotifier<TransactionState> {
  Ref get ref;
  GeolocatorPlatform get geolocator;

  Future<String?> performGuards({
    required Decimal amount,
    required String serviceCode,
    required FundingSource fundingSource,
    Map<String, String>? metadata,
  }) async {
    // 1. Compliance Check
    final complianceState = ref.read(complianceProvider);
    if (complianceState.isFrozen) {
      return 'ERR_COMPLIANCE_FROZEN';
    }

    // 2. EOD Check
    final eodService = ref.read(eodTimerServiceProvider.notifier);
    if (eodService.getCurrentEodStatus() == EodStatus.locked) {
      return 'ERR_EOD_LOCKED';
    }

    // 3. Geofence Check
    final authUser = ref.read(authProvider).user;
    if (authUser?.registeredLat != null && authUser?.registeredLng != null) {
      try {
        final position = await geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
        );
        final geofence = GeofenceService(shopLat: authUser!.registeredLat!, shopLng: authUser.registeredLng!);
        if (!geofence.isWithinGeofence(position.latitude, position.longitude)) {
          return 'ERR_GEOFENCE_BREACH';
        }
      } catch (e) {
        return 'ERR_GPS_UNAVAILABLE';
      }
    }

    // 4. Phone Validation
    final phone = metadata?['mobileNumber'] ?? metadata?['mobile'] ?? metadata?['identifier'] ?? '';
    bool shouldValidatePhone = serviceCode.contains('PREPAID_TOPUP') || serviceCode == 'ESSP' || serviceCode == 'PIN_PURCHASE';
    if (shouldValidatePhone && phone.isNotEmpty) {
      bool isTopUpPrefix = phone.startsWith('01');
      bool isExplicitTopUp = serviceCode.contains('PREPAID_TOPUP');
      if (isTopUpPrefix || isExplicitTopUp) {
        if (!ValidationService.isValidPhoneNumber(phone)) {
          return 'ERR_VAL_INVALID_PHONE_FORMAT';
        }
      }
    }

    // 5. Universal Amount Limit (STP Hard Cap)
    final hardLimit = fundingSource == FundingSource.CASH ? Decimal.fromInt(5000) : Decimal.fromInt(3000);
    if (amount > hardLimit) {
      return 'ERR_VAL_AMOUNT_EXCEEDS_LIMIT: Maximum RM ${hardLimit == Decimal.fromInt(3000) ? "3,000 per STP transaction" : "5,000"} per transaction';
    }

    return null; // All guards passed
  }
}
