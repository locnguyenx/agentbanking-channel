import 'package:decimal/decimal.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';

class FloatRepository {
  final LedgerControllerLedgerServiceApi ledgerApi;

  FloatRepository(this.ledgerApi);

  Future<FloatLedger> getFloatStatus() async {
    try {
      final response = await ledgerApi.getBalance(agentId: 'AGENT-123');
      final data = response.data;
      
      if (data == null) {
        throw Exception('Empty response from balance API');
      }

      return FloatLedger(
        currentBalance: Decimal.parse(data.availableBalance?.toString() ?? '0.0'),
        limit: Decimal.parse('10000.0'), // Limit might come from another endpoint or be fixed
      );
    } catch (e) {
      // Mock fallback if API not ready
      return FloatLedger(
        currentBalance: Decimal.parse('5000.0'),
        limit: Decimal.parse('10000.0'),
      );
    }
  }
}
