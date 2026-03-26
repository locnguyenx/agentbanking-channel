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

abstract class IMyKadScanner {
  Future<bool> isAvailable();
  Future<MyKadData?> scanMyKad();
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
  final String maskedPan;
  final String cardToken; // Provided by Secure Element/HSM

  CardData({required this.maskedPan, required this.cardToken});
}
