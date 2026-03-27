import 'package:flutter_test/flutter_test.dart';
import 'package:agentbanking_channel/features/hardware/mock_hardware_impl.dart';

void main() {
  test('MockMerchantTerminal returns valid IDs', () async {
    final terminal = MockMerchantTerminal();
    
    expect(await terminal.getTerminalId(), equals('TM-99887766'));
    expect(await terminal.getMerchantId(), equals('MC-11223344'));
  });
}
