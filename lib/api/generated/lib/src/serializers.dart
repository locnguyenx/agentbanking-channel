//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:agent_api/src/date_serializer.dart';
import 'package:agent_api/src/model/date.dart';

import 'package:agent_api/src/model/agent_response.dart';
import 'package:agent_api/src/model/application_submit_request.dart';
import 'package:agent_api/src/model/application_submit_response.dart';
import 'package:agent_api/src/model/balance_inquiry_external_request.dart';
import 'package:agent_api/src/model/balance_inquiry_request.dart';
import 'package:agent_api/src/model/balance_response.dart';
import 'package:agent_api/src/model/bill_pay_external_request.dart';
import 'package:agent_api/src/model/card_auth_request.dart';
import 'package:agent_api/src/model/cash_back_command.dart';
import 'package:agent_api/src/model/cash_back_response.dart';
import 'package:agent_api/src/model/create_agent_external_request.dart';
import 'package:agent_api/src/model/dashboard_response.dart';
import 'package:agent_api/src/model/dashboard_response_daily_stats_inner.dart';
import 'package:agent_api/src/model/deposit_external_request.dart';
import 'package:agent_api/src/model/discrepancy_checker_action_request.dart';
import 'package:agent_api/src/model/discrepancy_maker_action_request.dart';
import 'package:agent_api/src/model/duit_now_external_request.dart';
import 'package:agent_api/src/model/duit_now_request.dart';
import 'package:agent_api/src/model/e_wallet_topup_external_request.dart';
import 'package:agent_api/src/model/e_wallet_withdraw_external_request.dart';
import 'package:agent_api/src/model/error_response.dart';
import 'package:agent_api/src/model/error_response_error.dart';
import 'package:agent_api/src/model/essp_external_request.dart';
import 'package:agent_api/src/model/fee_config_request.dart';
import 'package:agent_api/src/model/fee_config_response.dart';
import 'package:agent_api/src/model/geo_location.dart';
import 'package:agent_api/src/model/jom_pay_external_request.dart';
import 'package:agent_api/src/model/kyc_verify_response.dart';
import 'package:agent_api/src/model/my_kad_verify_request.dart';
import 'package:agent_api/src/model/pin_purchase_command.dart';
import 'package:agent_api/src/model/pin_purchase_response.dart';
import 'package:agent_api/src/model/retail_cashback_external_request.dart';
import 'package:agent_api/src/model/retail_pin_purchase_external_request.dart';
import 'package:agent_api/src/model/retail_sale_command.dart';
import 'package:agent_api/src/model/retail_sale_external_request.dart';
import 'package:agent_api/src/model/retail_sale_response.dart';
import 'package:agent_api/src/model/reversal_request.dart';
import 'package:agent_api/src/model/settlement_response.dart';
import 'package:agent_api/src/model/topup_external_request.dart';
import 'package:agent_api/src/model/transaction_list_response.dart';
import 'package:agent_api/src/model/transaction_response.dart';
import 'package:agent_api/src/model/update_agent_request.dart';
import 'package:agent_api/src/model/withdrawal_external_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AgentResponse,
  ApplicationSubmitRequest,
  ApplicationSubmitResponse,
  BalanceInquiryExternalRequest,
  BalanceInquiryRequest,
  BalanceResponse,
  BillPayExternalRequest,
  CardAuthRequest,
  CashBackCommand,
  CashBackResponse,
  CreateAgentExternalRequest,
  DashboardResponse,
  DashboardResponseDailyStatsInner,
  DepositExternalRequest,
  DiscrepancyCheckerActionRequest,
  DiscrepancyMakerActionRequest,
  DuitNowExternalRequest,
  DuitNowRequest,
  EWalletTopupExternalRequest,
  EWalletWithdrawExternalRequest,
  ErrorResponse,
  ErrorResponseError,
  EsspExternalRequest,
  FeeConfigRequest,
  FeeConfigResponse,
  GeoLocation,
  JomPayExternalRequest,
  KycVerifyResponse,
  MyKadVerifyRequest,
  PinPurchaseCommand,
  PinPurchaseResponse,
  RetailCashbackExternalRequest,
  RetailPinPurchaseExternalRequest,
  RetailSaleCommand,
  RetailSaleExternalRequest,
  RetailSaleResponse,
  ReversalRequest,
  SettlementResponse,
  TopupExternalRequest,
  TransactionListResponse,
  TransactionResponse,
  UpdateAgentRequest,
  WithdrawalExternalRequest,
])
Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(String)]),
        () => MapBuilder<String, String>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltList, [FullType(AgentResponse)]),
        () => ListBuilder<AgentResponse>(),
      )
      ..addBuilderFactory(
        const FullType(BuiltMap, [FullType(String), FullType(JsonObject)]),
        () => MapBuilder<String, JsonObject>(),
      )
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer()))
    .build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
