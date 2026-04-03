import 'package:decimal/decimal.dart';
import 'package:agentbanking_channel/core/offline/offline_queue_service.dart';
import 'package:agentbanking_channel/features/transactions/repositories/transaction_repository.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';

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
          final fundingSourceStr = payload['fundingSource'] as String? ?? 'CASH';
          final fundingSource = FundingSource.values.firstWhere(
            (e) => e.name == fundingSourceStr,
            orElse: () => FundingSource.CASH,
          );
          final agentId = payload['agentId'] as String? ?? 'AGENT_UNKNOWN';
          
          final request = TransactionExecutionRequest(
            quoteId: payload['quoteId'],
            pinBlock: payload['pinBlock'],
            cardToken: payload['cardToken'],
            fundingSource: fundingSource,
            serviceCode: payload['serviceCode'],
            amount: payload['amount'] != null ? Decimal.parse(payload['amount'].toString()) : null,
          );

          final result = await transactionRepository.executeTransaction(
            request, 
            agentId, 
            idempotencyKey: idempotencyKey,
          );
          
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
