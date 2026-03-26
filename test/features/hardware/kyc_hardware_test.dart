import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/hardware/hardware_interfaces.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

void main() {
  group('IMyKadScanner Mock', () {
    test('MockMyKadScanner returns simulated patient data', () async {
      final scanner = MockMyKadScanner();
      final data = await scanner.scanMyKad();
      
      expect(data?.fullName, 'AHMAD BIN ABDULLAH');
      expect(data?.icNumber, contains('850101'));
    });
  });
}
