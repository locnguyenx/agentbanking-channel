import 'dart:async';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';

class MockCardReader implements ICardReader {
  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<CardData?> readCard() async {
    await Future.delayed(const Duration(seconds: 1));
    return CardData(
      maskedPan: '411111******1111',
      cardToken: 'MOCK_TOKEN_EYJ123',
    );
  }
}

class MockPinPad implements IPinPad {
  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<String?> capturePin() async {
    // Simulate customer entering 6-digit PIN
    await Future.delayed(const Duration(seconds: 2));
    return 'ENCRYPTED_PIN_BLOCK_ABC';
  }
}

class MockPrinter implements IPrinter {
  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<bool> printReceipt(String document) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print('--- MOCK PRINTER OUTPUT ---\n$document\n-----------------------');
    return true;
  }
}

class MockMyKadScanner implements IMyKadScanner {
  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<MyKadData?> scanMyKad() async {
    // Simulate chip reading latency
    await Future.delayed(const Duration(seconds: 3));
    return MyKadData(
      fullName: 'AHMAD BIN ABDULLAH',
      icNumber: '850101-01-5678',
      address: 'LOT 123, JALAN AMPANG, 50450 KUALA LUMPUR',
    );
  }
}

class MockMerchantTerminal implements IMerchantTerminal {
  @override
  Future<bool> isAvailable() async => true;
  @override
  Future<bool> displayQrCode(String qrPayload) async => true;
  @override
  Future<void> clearDisplay() async {}
}
