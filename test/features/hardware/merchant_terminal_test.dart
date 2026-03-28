import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

void main() {
  test('MockMerchantTerminal displays QR successfully', () async {
    final terminal = MockMerchantTerminal();
    
    expect(await terminal.displayQrCode('duitnow-qr-payload'), isTrue);
  });
}
