import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/features/settlement/models/float_models.dart';

class FloatRepository {
  final Dio dio;

  FloatRepository(this.dio);

  Future<FloatLedger> getFloatStatus() async {
    try {
      final response = await dio.get('/api/v1/float/status');
      // Assume the response body matches FloatLedger.fromJson or similar
      // For mock:
      return FloatLedger(
        currentBalance: Decimal.parse(response.data['currentBalance'].toString()),
        limit: Decimal.parse(response.data['limit'].toString()),
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
