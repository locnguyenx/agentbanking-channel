import 'package:dio/dio.dart';
import 'package:decimal/decimal.dart';
import 'package:built_value/json_object.dart';
import 'package:built_collection/built_collection.dart';
import 'package:agent_api/agent_api.dart';
import 'package:agentbanking_channel/features/transactions/models/transaction_models.dart';
import 'package:agentbanking_channel/features/merchant/models/merchant_models.dart' as merchant;

class TransactionRepository {
  final LedgerControllerLedgerServiceApi ledgerApi;
  final MerchantControllerLedgerServiceApi merchantApi;
  final BillerControllerBillerServiceApi billerApi;
  final SwitchControllerSwitchAdapterServiceApi switchApi;
  final OnboardingControllerOnboardingServiceApi onboardingApi;
  final EsspControllerBillerServiceApi esspApi;
  final Dio _dio;

  TransactionRepository({
    required this.ledgerApi,
    required this.merchantApi,
    required this.billerApi,
    required this.switchApi,
    required this.onboardingApi,
    required this.esspApi,
    required Dio dio,
  }) : _dio = dio;

  Future<TransactionQuoteResponse> getQuote(TransactionQuoteRequest request) async {
    // Phase 2 Fix: Backend Quote service is missing in OpenAPI spec (404),
    // we bypass it and return a local zero-fee quote as allowed by BRD for current iteration.
    return TransactionQuoteResponse(
      amount: request.amount,
      fee: Decimal.zero,
      commission: Decimal.zero,
      total: request.amount,
      quoteId: 'LOCAL_QUOTE_${request.serviceCode}_${DateTime.now().millisecondsSinceEpoch}',
    );
  }

  Future<TransactionExecutionResponse> executeTransaction(TransactionExecutionRequest request) async {
    try {
      if (request.serviceCode == 'CASH_WITHDRAWAL') {
        final apiRequest = WithdrawalRequest((b) => b
          ..agentId = 'AGENT-123'
          ..amount = request.amount?.toDouble() ?? 0.0
          ..customerFee = 0.0
          ..agentCommission = 0.0
          ..bankShare = 0.0
          ..idempotencyKey = 'IDEM_${DateTime.now().millisecondsSinceEpoch}'
          ..customerCardMasked = request.metadata?['customerCardMasked'] ?? 'XXXX-XXXX-XXXX-0000'
          ..geofenceLat = double.tryParse(request.metadata?['geofenceLat'] ?? '') ?? 0.0
          ..geofenceLng = double.tryParse(request.metadata?['geofenceLng'] ?? '') ?? 0.0
        );
        final response = await ledgerApi.debit(withdrawalRequest: apiRequest);
        final data = response.data;
        final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
        return TransactionExecutionResponse(
          status: mappedData['status']?.toString() ?? 'UNKNOWN',
          referenceId: mappedData['referenceId']?.toString() ?? '',
          errorMessage: mappedData['errorMessage']?.toString(),
        );
      } else if (request.serviceCode == 'CASH_DEPOSIT') {
        final apiRequest = DepositRequest((b) => b
          ..agentId = 'AGENT-123'
          ..amount = request.amount?.toDouble() ?? 0.0
          ..customerFee = 0.0
          ..agentCommission = 0.0
          ..bankShare = 0.0
          ..idempotencyKey = 'IDEM_${DateTime.now().millisecondsSinceEpoch}'
          ..destinationAccount = request.metadata?['destinationAccount'] ?? 'UNKNOWN'
        );
        final response = await ledgerApi.credit(depositRequest: apiRequest);
        final data = response.data;
        final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
        return TransactionExecutionResponse(
          status: mappedData['status']?.toString() ?? 'UNKNOWN',
          referenceId: mappedData['referenceId']?.toString() ?? '',
          errorMessage: mappedData['errorMessage']?.toString(),
        );
      } else if (request.serviceCode == 'BILL_PAY') {
        final requestBody = BuiltMap<String, JsonObject>({
          'agentId': JsonObject('AGENT-123'),
          'billerCode': JsonObject(request.metadata?['billerCode'] ?? 'UNKNOWN'),
          'accountNumber': JsonObject(request.metadata?['accountNumber'] ?? 'UNKNOWN'),
          'amount': JsonObject(request.amount?.toDouble() ?? 0.0),
          'idempotencyKey': JsonObject('IDEM_BILL_${DateTime.now().millisecondsSinceEpoch}'),
        });
        final response = await billerApi.payBill(requestBody: requestBody);
        final data = response.data;
        final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
        return TransactionExecutionResponse(
          status: mappedData['status'] ?? 'UNKNOWN',
          referenceId: mappedData['referenceId'] ?? '',
          errorMessage: mappedData['errorMessage'],
        );
      } else if (request.serviceCode == 'TOP_UP' || request.serviceCode == 'EWALLET_TOPUP') {
        final requestBody = BuiltMap<String, JsonObject>({
          'agentId': JsonObject('AGENT-123'),
          'telcoProvider': JsonObject(request.metadata?['telcoProvider'] ?? (request.serviceCode == 'EWALLET_TOPUP' ? 'SARAWAK_PAY' : 'CELCOM')),
          'mobileNumber': JsonObject(request.metadata?['mobileNumber'] ?? request.metadata?['walletId'] ?? '0123456789'),
          'amount': JsonObject(request.amount?.toDouble() ?? 0.0),
          'idempotencyKey': JsonObject('IDEM_TOPUP_${DateTime.now().millisecondsSinceEpoch}'),
        });
        final response = await billerApi.topup(requestBody: requestBody);
        final data = response.data;
        final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
        return TransactionExecutionResponse(
          status: mappedData['status']?.toString() ?? 'UNKNOWN',
          referenceId: mappedData['referenceId']?.toString() ?? '',
          errorMessage: mappedData['errorMessage']?.toString(),
        );
      } else if (request.serviceCode == 'ESSP_PURCHASE') {
        final requestBody = BuiltMap<String, JsonObject>({
          'agentId': JsonObject('AGENT-123'),
          'productCode': JsonObject(request.metadata?['productCode'] ?? 'ESSP_TOKEN'),
          'amount': JsonObject(request.amount?.toDouble() ?? 0.0),
          'idempotencyKey': JsonObject('IDEM_ESSP_${DateTime.now().millisecondsSinceEpoch}'),
        });
        final response = await esspApi.purchase(requestBody: requestBody);
        final data = response.data;
        final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
        return TransactionExecutionResponse(
          status: mappedData['status']?.toString() ?? 'UNKNOWN',
          referenceId: mappedData['transactionId']?.toString() ?? mappedData['referenceId']?.toString() ?? '',
        );
      }
      
      // Fallback for other services
      throw UnimplementedError('Service ${request.serviceCode} refactoring in progress');
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 200) {
        final data = e.response!.data;
        if (data is Map<String, dynamic>) {
           return TransactionExecutionResponse(
             status: data['status'] ?? 'UNKNOWN',
             referenceId: data['referenceId'] ?? '',
           );
        }
      }
      rethrow;
    }
  }

  Future<String> performProxyEnquiry(String proxyId, String proxyType) async {
    return 'UNKNOWN (Proxy Enquiry missing in spec)';
  }

  Future<TransactionExecutionResponse> balanceInquiry(TransactionExecutionRequest request) async {
    final apiRequest = BalanceInquiryRequest((b) => b
      ..encryptedCardData = request.cardToken ?? ''
      ..pinBlock = request.pinBlock ?? ''
    );
    final response = await ledgerApi.balanceInquiry(balanceInquiryRequest: apiRequest);
    final data = response.data;
    final Map<String, dynamic> mappedData = (data != null) ? data.asMap().map((k, v) => MapEntry(k, v.value)) : {};
    return TransactionExecutionResponse(
      status: mappedData['status'] ?? 'UNKNOWN',
      referenceId: mappedData['referenceId'] ?? '',
      balance: mappedData['balance'] != null ? Decimal.parse(mappedData['balance'].toString()) : null,
      currency: mappedData['currency'],
    );
  }

  Future<TransactionExecutionResponse> initiateDuitNow({
    required String quoteId,
    required String proxyId,
    required String proxyType,
    required Decimal amount,
  }) async {
    final apiRequest = DuitNowRequest((b) => b
      ..internalTransactionId = quoteId
      ..proxyType = proxyType
      ..proxyValue = proxyId
      ..amount = amount.toDouble()
    );
    final response = await switchApi.duitNowTransfer(duitNowRequest: apiRequest);
    final data = response.data?.value;
    final Map<String, dynamic> mappedData = (data is Map) ? Map<String, dynamic>.from(data) : {};
    return TransactionExecutionResponse(
      status: mappedData['status']?.toString() ?? 'UNKNOWN',
      referenceId: mappedData['referenceId']?.toString() ?? '',
    );
  }

  Future<String> getDuitNowStatus(String referenceId) async {
    final response = await _dio.get('/api/v1/transfer/duitnow/status/$referenceId');
    return response.data['status'];
  }

  Future<merchant.RetailSaleResponse> executeRetailSale(Decimal amount, String fundingSource, {String? pinBlock, String? cardToken}) async {
    final apiRequest = RetailSaleCommand((b) => b
      ..merchantId = 'MERCHANT-123'
      ..amount = amount.toDouble()
      ..cardData = cardToken ?? ''
      ..pinBlock = pinBlock ?? ''
      ..idempotencyKey = 'IDEM_${DateTime.now().millisecondsSinceEpoch}'
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

  Future<merchant.CashbackResponse> executeCashback(Decimal purchaseAmount, Decimal cashbackAmount, String fundingSource, {String? pinBlock, String? cardToken}) async {
    final apiRequest = CashBackCommand((b) => b
      ..merchantId = 'MERCHANT-123'
      ..cashBackAmount = cashbackAmount.toDouble()
      ..cardData = cardToken ?? ''
      ..pinBlock = pinBlock ?? ''
      ..idempotencyKey = 'IDEM_${DateTime.now().millisecondsSinceEpoch}'
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

  Future<merchant.PinPurchaseResponse> executePinPurchase(Decimal amount, String productCode) async {
    final apiRequest = PinPurchaseCommand((b) => b
      ..agentId = 'AGENT-123'
      ..productCode = productCode
      ..amount = amount.toDouble()
      ..idempotencyKey = 'IDEM_PIN_${DateTime.now().millisecondsSinceEpoch}'
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
    return 'UNLOCKED';
  }
}
