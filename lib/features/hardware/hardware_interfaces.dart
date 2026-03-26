/// Abstract interfaces for POS Hardware Peripherals
///
/// These interfaces decouple the Flutter application from specific
/// vendor-proprietary Android SDKs (Sunmi, Pax, Aisino, etc.)

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

class CardData {
  final String maskedPan;
  final String cardToken; // Provided by Secure Element/HSM

  CardData({required this.maskedPan, required this.cardToken});
}
