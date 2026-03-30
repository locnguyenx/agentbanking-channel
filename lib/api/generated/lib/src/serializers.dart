// @dart=2.19
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
import 'package:agent_api/src/model/balance_inquiry_request.dart';
import 'package:agent_api/src/model/card_auth_request.dart';
import 'package:agent_api/src/model/cash_back_command.dart';
import 'package:agent_api/src/model/cash_back_response.dart';
import 'package:agent_api/src/model/create_agent_request.dart';
import 'package:agent_api/src/model/deposit_request.dart';
import 'package:agent_api/src/model/duit_now_request.dart';
import 'package:agent_api/src/model/pin_purchase_command.dart';
import 'package:agent_api/src/model/pin_purchase_response.dart';
import 'package:agent_api/src/model/retail_sale_command.dart';
import 'package:agent_api/src/model/retail_sale_response.dart';
import 'package:agent_api/src/model/reversal_request.dart';
import 'package:agent_api/src/model/update_agent_request.dart';
import 'package:agent_api/src/model/withdrawal_request.dart';

part 'serializers.g.dart';

@SerializersFor([
  AgentResponse,
  BalanceInquiryRequest,
  CardAuthRequest,
  CashBackCommand,
  CashBackResponse,
  CreateAgentRequest,
  DepositRequest,
  DuitNowRequest,
  PinPurchaseCommand,
  PinPurchaseResponse,
  RetailSaleCommand,
  RetailSaleResponse,
  ReversalRequest,
  UpdateAgentRequest,
  WithdrawalRequest,
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
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
