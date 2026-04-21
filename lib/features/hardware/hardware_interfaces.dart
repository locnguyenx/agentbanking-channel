/// Abstract interfaces for POS Hardware Peripherals
///
/// These interfaces decouple the Flutter application from specific
/// vendor-proprietary Android SDKs (Sunmi, Pax, Aisino, etc.)
library;

abstract class ICardReader {
  Future<bool> isAvailable();
  Future<CardData?> readCard();
}

abstract class IPinPad {
  Future<bool> isAvailable();
  Future<String?> capturePin(); 
}

abstract class IPrinter {
  Future<bool> isAvailable();
  Future<bool> printReceipt(String document);
}

abstract class IMyKadScanner {
  Future<bool> isAvailable();
  Future<MyKadData?> scanMyKad();
}

/// Merchant Terminal Display — renders Dynamic DuitNow QR codes for customer scanning.
/// Phase 2 only. HAL contract isolates Flutter from vendor QR SDK.
/// Design §3.1 IMerchantTerminal
abstract class IMerchantTerminal {
  Future<bool> isAvailable();
  /// Renders a DuitNow QR payload string on the merchant display.
  /// Returns true if displayed successfully.
  Future<bool> displayQrCode(String qrPayload);
  /// Clears the QR display after payment confirmed or timed out.
  Future<void> clearDisplay();
}

class MyKadData {
  final String fullName;
  final String icNumber;
  final String address;
  final String? photoBase64;

  MyKadData({
    required this.fullName,
    required this.icNumber,
    required this.address,
    this.photoBase64,
  });
}

class CardData {
  final String pan;
  final String cardToken; // Provided by Secure Element/HSM

  CardData({required this.pan, required this.cardToken});
}
