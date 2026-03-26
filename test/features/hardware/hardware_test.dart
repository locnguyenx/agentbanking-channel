import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

void main() {
  group('HAL Mock Implementations', () {
    test('MockCardReader returns masked PAN correctly', () async {
      final reader = MockCardReader();
      final data = await reader.readCard();
      expect(data?.maskedPan, startsWith('411111'));
      expect(data?.maskedPan, endsWith('1111'));
    });

    test('MockPinPad returns encrypted PIN block', () async {
      final pinpad = MockPinPad();
      final pinBlock = await pinpad.capturePin();
      expect(pinBlock, contains('ENCRYPTED_PIN_BLOCK'));
    });

    test('MockPrinter successfully prints', () async {
      final printer = MockPrinter();
      final success = await printer.printReceipt('Test Receipt');
      expect(success, isTrue);
    });
  });
}
