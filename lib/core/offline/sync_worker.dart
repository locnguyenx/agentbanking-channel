import 'package:dio/dio.dart';
import '../offline/offline_queue_service.dart';
import '../../features/transactions/repositories/transaction_repository.dart';
import '../../features/transactions/models/transaction_models.dart';

class SyncWorker {
  final OfflineQueueService queueService;
  final TransactionRepository transactionRepository;
  bool _isSyncing = false;

  SyncWorker({
    required this.queueService,
    required this.transactionRepository,
  });

  Future<void> sync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final pendingTransactions = await queueService.getPending();
      
      for (final tx in pendingTransactions) {
        final payload = tx['payload'] as Map<String, dynamic>;
        final idempotencyKey = tx['idempotencyKey'] as String;
        
        try {
          // Wrap execution in a request with Idempotency Key
          // In real Dio client, we'd add this to headers via interceptor
          final request = TransactionExecutionRequest(
            quoteId: payload['quoteId'],
            pinBlock: payload['pinBlock'],
            cardToken: payload['cardToken'],
          );

          final result = await transactionRepository.executeTransaction(request);
          
          if (result.status == 'SUCCESS') {
            await queueService.remove(tx['id']);
          }
        } catch (e) {
          // If server error, stop sync and try again later
          print('Sync failed for transaction ${tx['id']}: $e');
          break; 
        }
      }
    } finally {
      _isSyncing = false;
    }
  }
}
