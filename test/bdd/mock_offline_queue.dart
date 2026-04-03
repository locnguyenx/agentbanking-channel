import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:mockito/mockito.dart';

class MockOfflineQueueService extends Mock implements OfflineQueueService {
  final List<Map<String, dynamic>> _queue = [];

  @override
  Future<void> init() async {}
  
  @override
  Future<void> enqueue(Map<String, dynamic> payload, String idempotencyKey) async {
    _queue.add({
      'payload': payload,
      'idempotencyKey': idempotencyKey,
    });
  }

  @override
  Future<int> getCount() async {
    return _queue.length;
  }

  @override
  Future<List<Map<String, dynamic>>> getPending() async {
    return _queue;
  }
}
