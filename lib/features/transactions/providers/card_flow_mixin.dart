import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/transactions/providers/transaction_provider.dart';

/// Shared card + PIN capture logic used by both CardFlowNotifier and MerchantNotifier.
///
/// Subclass must provide:
/// - `cardReader`, `pinPad`
/// - `isMounted` getter
/// - `updateState(TransactionStatus, {String? error})` callback
mixin CardFlowMixin {
  ICardReader get cardReader;
  IPinPad get pinPad;
  bool get isMounted;

  /// Runs the card insertion → PIN entry sub-flow.
  /// Returns `(cardToken, pinBlock)` on success, or null if cancelled/failed.
  /// The caller is responsible for setting the initial `waitingCard` status.
  Future<CardPinResult?> captureCardAndPin({
    required void Function(TransactionStatus status, {String? error}) updateState,
  }) async {
    try {
      final cardData = await cardReader.readCard();
      if (!isMounted) return null;
      if (cardData == null) {
        updateState(TransactionStatus.failed, error: 'Card Read Failed');
        return null;
      }

      updateState(TransactionStatus.waitingPin);
      final pinBlock = await pinPad.capturePin();
      if (!isMounted) return null;
      if (pinBlock == null) {
        updateState(TransactionStatus.failed, error: 'PIN Entry Cancelled');
        return null;
      }

      return CardPinResult(cardToken: cardData.cardToken, pinBlock: pinBlock);
    } catch (e) {
      if (isMounted) {
        updateState(TransactionStatus.failed, error: e.toString());
      }
      return null;
    }
  }
}

class CardPinResult {
  final String cardToken;
  final String pinBlock;

  CardPinResult({required this.cardToken, required this.pinBlock});
}
