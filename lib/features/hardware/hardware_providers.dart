import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

final myKadScannerProvider = Provider<IMyKadScanner>((ref) {
  return MockMyKadScanner();
});

final cardReaderProvider = Provider<ICardReader>((ref) {
  return MockCardReader();
});

final pinPadProvider = Provider<IPinPad>((ref) {
  return MockPinPad();
});

final printerProvider = Provider<IPrinter>((ref) {
  return MockPrinter();
});
