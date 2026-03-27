import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';

final reversalServiceProvider = Provider<ReversalService>((ref) {
  final queueService = ref.watch(offlineQueueServiceProvider);
  return ReversalService(queueService);
});

class ReversalService {
  final OfflineQueueService _queueService;

  ReversalService(this._queueService);

  Future<void> queueReversal(Map<String, dynamic> originalRequest) async {
    // Generate MTI 0400 style reversal payload
    final reversalPayload = {
      ...originalRequest,
      'mti': '0400',
      'reversalReason': 'TIMEOUT',
      'originalIdempotencyKey': originalRequest['idempotencyKey'],
    };

    await _queueService.enqueue(
      reversalPayload,
      'REV_${originalRequest['idempotencyKey']}',
    );
  }
}
