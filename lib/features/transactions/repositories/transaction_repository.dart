import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:built_value/json_object.dart';
import 'package:built_collection/built_collection.dart';
import 'package:agent_api/agent_api.dart';
import 'package:uuid/uuid.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart' as models;
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart' as merchant;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agentbanking_channel/api/api_providers.dart';
import 'package:agentbanking_channel/core/network/dio_provider.dart';

class TransactionRepository {
  final LedgerControllerLedgerServiceApi ledgerApi;
  final MerchantControllerLedgerServiceApi merchantApi;
  final BillerControllerBillerServiceApi billerApi;
  final SwitchControllerSwitchAdapterServiceApi switchApi;
  final OnboardingControllerOnboardingServiceApi onboardingApi;
  final EsspControllerBillerServiceApi esspApi;
  final EWalletControllerBillerServiceApi ewalletApi;
  final TransactionControllerSwitchAdapterServiceApi transactionApi;
  final OrchestratorControllerOrchestratorServiceApi orchestratorApi;
  final ComplianceControllerRulesServiceApi complianceApi;
  final Duration pollingInterval;
  final Dio _dio;

  TransactionRepository({
    required this.ledgerApi,
    required this.merchantApi,
    required this.billerApi,
    required this.switchApi,
    required this.onboardingApi,
    required this.esspApi,
    required this.ewalletApi,
    required this.transactionApi,
    required this.orchestratorApi,
    required this.complianceApi,
    required Dio dio,
    this.pollingInterval = const Duration(seconds: 2),
  }) : _dio = dio;

  String _generateIdempotencyKey() => Uuid().v4();

  Future<models.TransactionQuoteResponse> getQuote(models.TransactionQuoteRequest request) async {
    final apiRequest = TransactionQuoteRequest((b) => b
      ..serviceCode = request.serviceCode
      ..amount = request.amount.toString()
      ..agentId = request.agentId
      ..fundingSource = TransactionQuoteRequestFundingSourceEnum.valueOf(request.fundingSource.name)
      ..billerRouting = request.billerRouting != null ? TransactionQuoteRequestBillerRoutingEnum.valueOf(request.billerRouting!.name) : null
    );

    final response = await transactionApi.getTransactionQuote(transactionQuoteRequest: apiRequest);
    final data = response.data;
    
    if (data == null) throw Exception('Quote failed: empty response');

    return models.TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.parse(data.fee.toString()),
      commission: Decimal.parse(data.commission.toString()),
      total: Decimal.parse(data.total.toString()),
      quoteId: data.quoteId,
    );
  }

  Future<models.TransactionExecutionResponse> executeTransaction(models.TransactionExecutionRequest request, String agentId, {String? idempotencyKey}) async {
    final effectiveKey = idempotencyKey ?? _generateIdempotencyKey();
    
    try {
      final transactionType = _mapServiceCodeToType(request.serviceCode);
      
      final apiRequest = TransactionStartRequest((b) => b
        ..transactionType = transactionType
        ..agentId = agentId
        ..amount = request.amount?.toDouble() ?? 0.0
        ..idempotencyKey = effectiveKey
        ..geofenceLat = double.tryParse(request.metadata?['geofenceLat'] ?? '')
        ..geofenceLng = double.tryParse(request.metadata?['geofenceLng'] ?? '')
        // Type-specific field mapping
        ..pan = request.metadata?['customerCardMasked']
        ..pinBlock = request.pinBlock
        ..customerCardMasked = request.metadata?['customerCardMasked']
        ..destinationAccount = request.metadata?['destinationAccount']
        ..billerCode = request.metadata?['billerCode']
        ..ref1 = request.metadata?['accountNumber'] ?? request.metadata?['ref1']
        ..ref2 = request.metadata?['ref2']
        ..proxyType = request.metadata?['proxyType'] != null ? TransactionStartRequestProxyTypeEnum.valueOf(request.metadata!['proxyType']!) : null
        ..proxyValue = request.metadata?['proxyValue']
        ..agentTier = TransactionStartRequestAgentTierEnum.tIER1 // Default for now
      );

      final response = await orchestratorApi.startTransaction(transactionStartRequest: apiRequest);
      final startData = response.data;
      
      if (startData == null) throw Exception('Transaction failed to start: empty response');
      
      if (startData.status == TransactionStartResponseStatusEnum.PENDING) {
        return _pollTransactionStatus(startData.workflowId!);
      } else {
        return models.TransactionExecutionResponse(
          status: startData.status?.name ?? 'UNKNOWN',
          referenceId: startData.workflowId ?? '',
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  TransactionType _mapServiceCodeToType(String? serviceCode) {
    switch (serviceCode) {
      case 'CASH_WITHDRAWAL': return TransactionType.CASH_WITHDRAWAL;
      case 'CASH_DEPOSIT': return TransactionType.CASH_DEPOSIT;
      case 'BILL_PAYMENT':
      case 'BILL_PAY':
      case 'JOMPAY': return TransactionType.BILL_PAYMENT;
      case 'TOP_UP': return TransactionType.PREPAID_TOPUP;
      case 'DUITNOW_TRANSFER': return TransactionType.DUITNOW_TRANSFER;
      case 'CASHLESS_PAY': return TransactionType.CASHLESS_PAYMENT;
      case 'EWALLET_TOPUP':
      case 'SARAWAK_PAY': return TransactionType.EWALLET_TOPUP;
      case 'EWALLET_WITHDRAW':
      case 'SARAWAK_PAY_WITHDRAW': return TransactionType.EWALLET_WITHDRAWAL;
      case 'ESSP_PURCHASE': return TransactionType.ESSP_PURCHASE;
      case 'PIN_PURCHASE': return TransactionType.PIN_PURCHASE;
      default: return TransactionType.CASH_WITHDRAWAL;
    }
  }

  Future<models.TransactionExecutionResponse> _pollTransactionStatus(String workflowId) async {
    int attempts = 0;
    const maxAttempts = 30; // 60 seconds (2s interval)
    
    print('DEBUG: Polling status for $workflowId');
    while (attempts < maxAttempts) {
      final statusResponse = await orchestratorApi.getTransactionStatus(workflowId: workflowId);
      final statusData = statusResponse.data;
      
      print('DEBUG: Status for $workflowId: ${statusData?.status}');
      
      if (statusData == null) throw Exception('Failed to get transaction status');
      
      if (statusData.status == TransactionStatusResponseStatusEnum.COMPLETED) {
        return models.TransactionExecutionResponse(
          status: 'SUCCESS',
          referenceId: statusData.referenceNumber ?? workflowId,
          amount: statusData.amount != null ? Decimal.parse(statusData.amount.toString()) : null,
        );
      } else if (statusData.status == TransactionStatusResponseStatusEnum.FAILED) {
        return models.TransactionExecutionResponse(
          status: 'FAILED',
          referenceId: statusData.referenceNumber ?? workflowId,
          errorMessage: statusData.errorMessage ?? 'Transaction failed',
        );
      }
      
      // Still pending, running, or compensating
      await Future.delayed(pollingInterval);
      attempts++;
    }
    
    throw Exception('Transaction timed out after polling for status');
  }

  Future<String> getBillerStatus(String transactionId) async {
    final response = await _dio.get('/api/v1/bill/status/$transactionId');
    return response.data['status'];
  }

  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    final response = await switchApi.proxyEnquiry(proxyId: proxyId, proxyType: proxyType);
    return response.data?.toString() ?? '';
  }

  Future<models.TransactionExecutionResponse> balanceInquiry(models.TransactionExecutionRequest request, String agentId) async {
    final apiRequest = BalanceInquiryExternalRequest((b) => b
      ..encryptedCardData = request.cardToken ?? ''
      ..pinBlock = request.pinBlock ?? ''
    );
    final response = await ledgerApi.balanceInquiry(balanceInquiryExternalRequest: apiRequest);
    final data = response.data;
    
    return models.TransactionExecutionResponse(
      status: data?.currency != null ? 'SUCCESS' : 'UNKNOWN',
      referenceId: data?.lastTransactionId ?? '',
      balance: data?.availableBalance != null ? Decimal.parse(data!.availableBalance!.toString()) : null,
      currency: data?.currency,
    );
  }

  Future<models.TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    final apiRequest = DuitNowRequest((b) => b
      ..internalTransactionId = quoteId
      ..proxyType = proxyType
      ..proxyValue = proxyId
      ..amount = amount.toString()
    );
    
    final response = await switchApi.duitNowTransfer(duitNowRequest: apiRequest);
    final data = response.data;
    
    return models.TransactionExecutionResponse(
      status: data?.status?.name ?? 'UNKNOWN',
      referenceId: data?.transactionId ?? '',
    );
  }

  Future<Map<String, String>> generateQrSale(Decimal amount, String agentId) async {
    final response = await _dio.post('/api/v1/retail/qr', data: {
      'amount': amount.toDouble(),
      'agentId': agentId,
      'idempotencyKey': _generateIdempotencyKey(),
    });
    return {
      'qrPayload': response.data['qrPayload'],
      'referenceId': response.data['referenceId'],
    };
  }

  Future<Map<String, dynamic>> getDuitNowStatus(String referenceId) async {
    // Current platform status endpoint for DuitNow
    final response = await _dio.get('/api/v1/transfer/duitnow/status/$referenceId');
    return response.data as Map<String, dynamic>;
  }

  Future<merchant.RetailSaleResponse> executeRetailSale(Decimal amount, String agentId, {String? pinBlock, String? cardToken}) async {
    final apiRequest = RetailSaleCommand((b) => b
      ..merchantId = agentId
      ..amount = amount.toString()
      ..cardData = cardToken ?? ''
      ..pinBlock = pinBlock ?? ''
      ..idempotencyKey = _generateIdempotencyKey()
    );
    final response = await merchantApi.processRetailSale(retailSaleCommand: apiRequest);
    final data = response.data;
    if (data == null) throw Exception('Retail Sale failed: empty response');
    return merchant.RetailSaleResponse(
      floatCreditAmount: Decimal.parse(data.netToMerchant?.toString() ?? '0'),
      mdrAmount: Decimal.parse(data.mdrAmount?.toString() ?? '0'),
      receiptReference: data.transactionId ?? '',
    );
  }

  Future<merchant.CashbackResponse> executeCashback(Decimal purchaseAmount, Decimal cashbackAmount, String agentId, {String? pinBlock, String? cardToken}) async {
    final apiRequest = CashBackCommand((b) => b
      ..merchantId = agentId
      ..cashBackAmount = cashbackAmount.toString()
      ..cardData = cardToken ?? ''
      ..pinBlock = pinBlock ?? ''
      ..idempotencyKey = _generateIdempotencyKey()
    );
    final response = await merchantApi.processCashBack(cashBackCommand: apiRequest);
    final data = response.data;
    if (data == null) throw Exception('Cashback failed: empty response');
    return merchant.CashbackResponse(
      purchaseAmount: purchaseAmount, 
      cashBackAmount: Decimal.parse(data.cashBackAmount?.toString() ?? '0'),
      receiptReference: data.transactionId ?? '',
    );
  }

  Future<merchant.PinPurchaseResponse> executePinPurchase(Decimal amount, String agentId, String productCode) async {
    final apiRequest = PinPurchaseCommand((b) => b
      ..agentId = agentId
      ..productCode = productCode
      ..amount = amount.toString()
      ..idempotencyKey = _generateIdempotencyKey()
    );
    final response = await merchantApi.processPinPurchase(pinPurchaseCommand: apiRequest);
    final data = response.data;
    if (data == null) throw Exception('PIN Purchase failed: empty response');
    return merchant.PinPurchaseResponse(
      pinCode: data.pinCode ?? '',
      receiptReference: data.transactionId ?? '',
      commissionEarned: Decimal.parse(data.commission?.toString() ?? '0'),
    );
  }

  Future<String> getComplianceStatus() async {
    final response = await complianceApi.getComplianceStatus();
    return response.data ?? 'UNLOCKED';
  }
}

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepository(
    ledgerApi: ref.watch(ledgerApiProvider),
    merchantApi: ref.watch(merchantApiProvider),
    billerApi: ref.watch(billerApiProvider),
    switchApi: ref.watch(switchApiProvider),
    onboardingApi: ref.watch(onboardingApiProvider),
    esspApi: ref.watch(esspApiProvider),
    ewalletApi: ref.watch(ewalletApiProvider),
    transactionApi: ref.watch(transactionApiProvider),
    orchestratorApi: ref.watch(orchestratorApiProvider),
    complianceApi: ref.watch(complianceApiProvider),
    dio: ref.watch(dioProvider),
    pollingInterval: const Duration(seconds: 2),
  );
});
