import 'package:decimal/decimal.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';

class FloatRepository {
  final LedgerControllerLedgerServiceApi ledgerApi;

  FloatRepository(this.ledgerApi);

  Future<FloatLedger> getFloatStatus(String agentId) async {
    final response = await ledgerApi.getBalance(agentId: agentId);
    final data = response.data;
    
    if (data == null) {
      throw Exception('Empty response from balance API');
    }

    return FloatLedger(
      currentBalance: Decimal.parse(data.availableBalance?.toString() ?? '0.0'),
      limit: Decimal.parse('10000.0'), // Limit might come from another endpoint or be fixed
    );
  }
}
