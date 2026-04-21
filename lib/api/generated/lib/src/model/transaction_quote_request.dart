//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_quote_request.g.dart';

/// TransactionQuoteRequest
///
/// Properties:
/// * [serviceCode] - Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
/// * [amount] 
/// * [agentId] 
/// * [fundingSource] 
/// * [billerRouting] 
@BuiltValue()
abstract class TransactionQuoteRequest implements Built<TransactionQuoteRequest, TransactionQuoteRequestBuilder> {
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueField(wireName: r'serviceCode')
  TransactionQuoteRequestServiceCodeEnum get serviceCode;
  // enum serviceCodeEnum {  CASH_WITHDRAWAL,  CASH_DEPOSIT,  BILL_PAYMENT,  DUITNOW_TRANSFER,  CASHLESS_PAYMENT,  PIN_BASED_PURCHASE,  PREPAID_TOPUP,  EWALLET_WITHDRAWAL,  EWALLET_TOPUP,  ESSP_PURCHASE,  PIN_PURCHASE,  RETAIL_SALE,  HYBRID_CASHBACK,  BALANCE_INQUIRY,  JOMPAY,  ASTRO_RPN,  TM_RPN,  CELCOM_TOPUP,  M1_TOPUP,  };

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'fundingSource')
  TransactionQuoteRequestFundingSourceEnum get fundingSource;
  // enum fundingSourceEnum {  CARD_EMV,  CASH,  DUITNOW_MOBILE,  DUITNOW_MYKAD,  DUITNOW_BRN,  MYKAD_BIOMETRIC,  DUITNOW_QR,  };

  @BuiltValueField(wireName: r'billerRouting')
  TransactionQuoteRequestBillerRoutingEnum? get billerRouting;
  // enum billerRoutingEnum {  ON_US,  OFF_US,  };

  TransactionQuoteRequest._();

  factory TransactionQuoteRequest([void updates(TransactionQuoteRequestBuilder b)]) = _$TransactionQuoteRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionQuoteRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionQuoteRequest> get serializer => _$TransactionQuoteRequestSerializer();
}

class _$TransactionQuoteRequestSerializer implements PrimitiveSerializer<TransactionQuoteRequest> {
  @override
  final Iterable<Type> types = const [TransactionQuoteRequest, _$TransactionQuoteRequest];

  @override
  final String wireName = r'TransactionQuoteRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionQuoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'serviceCode';
    yield serializers.serialize(
      object.serviceCode,
      specifiedType: const FullType(TransactionQuoteRequestServiceCodeEnum),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    yield r'fundingSource';
    yield serializers.serialize(
      object.fundingSource,
      specifiedType: const FullType(TransactionQuoteRequestFundingSourceEnum),
    );
    if (object.billerRouting != null) {
      yield r'billerRouting';
      yield serializers.serialize(
        object.billerRouting,
        specifiedType: const FullType(TransactionQuoteRequestBillerRoutingEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionQuoteRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionQuoteRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'serviceCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionQuoteRequestServiceCodeEnum),
          ) as TransactionQuoteRequestServiceCodeEnum;
          result.serviceCode = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentId = valueDes;
          break;
        case r'fundingSource':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionQuoteRequestFundingSourceEnum),
          ) as TransactionQuoteRequestFundingSourceEnum;
          result.fundingSource = valueDes;
          break;
        case r'billerRouting':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionQuoteRequestBillerRoutingEnum),
          ) as TransactionQuoteRequestBillerRoutingEnum;
          result.billerRouting = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionQuoteRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionQuoteRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class TransactionQuoteRequestServiceCodeEnum extends EnumClass {

  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'CASH_WITHDRAWAL')
  static const TransactionQuoteRequestServiceCodeEnum CASH_WITHDRAWAL = _$transactionQuoteRequestServiceCodeEnum_CASH_WITHDRAWAL;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'CASH_DEPOSIT')
  static const TransactionQuoteRequestServiceCodeEnum CASH_DEPOSIT = _$transactionQuoteRequestServiceCodeEnum_CASH_DEPOSIT;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'BILL_PAYMENT')
  static const TransactionQuoteRequestServiceCodeEnum BILL_PAYMENT = _$transactionQuoteRequestServiceCodeEnum_BILL_PAYMENT;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'DUITNOW_TRANSFER')
  static const TransactionQuoteRequestServiceCodeEnum DUITNOW_TRANSFER = _$transactionQuoteRequestServiceCodeEnum_DUITNOW_TRANSFER;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'CASHLESS_PAYMENT')
  static const TransactionQuoteRequestServiceCodeEnum CASHLESS_PAYMENT = _$transactionQuoteRequestServiceCodeEnum_CASHLESS_PAYMENT;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'PIN_BASED_PURCHASE')
  static const TransactionQuoteRequestServiceCodeEnum PIN_BASED_PURCHASE = _$transactionQuoteRequestServiceCodeEnum_PIN_BASED_PURCHASE;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'PREPAID_TOPUP')
  static const TransactionQuoteRequestServiceCodeEnum PREPAID_TOPUP = _$transactionQuoteRequestServiceCodeEnum_PREPAID_TOPUP;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'EWALLET_WITHDRAWAL')
  static const TransactionQuoteRequestServiceCodeEnum EWALLET_WITHDRAWAL = _$transactionQuoteRequestServiceCodeEnum_EWALLET_WITHDRAWAL;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'EWALLET_TOPUP')
  static const TransactionQuoteRequestServiceCodeEnum EWALLET_TOPUP = _$transactionQuoteRequestServiceCodeEnum_EWALLET_TOPUP;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'ESSP_PURCHASE')
  static const TransactionQuoteRequestServiceCodeEnum ESSP_PURCHASE = _$transactionQuoteRequestServiceCodeEnum_ESSP_PURCHASE;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'PIN_PURCHASE')
  static const TransactionQuoteRequestServiceCodeEnum PIN_PURCHASE = _$transactionQuoteRequestServiceCodeEnum_PIN_PURCHASE;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'RETAIL_SALE')
  static const TransactionQuoteRequestServiceCodeEnum RETAIL_SALE = _$transactionQuoteRequestServiceCodeEnum_RETAIL_SALE;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'HYBRID_CASHBACK')
  static const TransactionQuoteRequestServiceCodeEnum HYBRID_CASHBACK = _$transactionQuoteRequestServiceCodeEnum_HYBRID_CASHBACK;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'BALANCE_INQUIRY')
  static const TransactionQuoteRequestServiceCodeEnum BALANCE_INQUIRY = _$transactionQuoteRequestServiceCodeEnum_BALANCE_INQUIRY;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'JOMPAY')
  static const TransactionQuoteRequestServiceCodeEnum JOMPAY = _$transactionQuoteRequestServiceCodeEnum_JOMPAY;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'ASTRO_RPN')
  static const TransactionQuoteRequestServiceCodeEnum ASTRO_RPN = _$transactionQuoteRequestServiceCodeEnum_ASTRO_RPN;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'TM_RPN')
  static const TransactionQuoteRequestServiceCodeEnum TM_RPN = _$transactionQuoteRequestServiceCodeEnum_TM_RPN;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'CELCOM_TOPUP')
  static const TransactionQuoteRequestServiceCodeEnum CELCOM_TOPUP = _$transactionQuoteRequestServiceCodeEnum_CELCOM_TOPUP;
  /// Service code for the transaction. Legacy codes (JOMPAY, ASTRO_RPN, TM_RPN, CELCOM_TOPUP, M1_TOPUP) are mapped to canonical types.
  @BuiltValueEnumConst(wireName: r'M1_TOPUP')
  static const TransactionQuoteRequestServiceCodeEnum m1TOPUP = _$transactionQuoteRequestServiceCodeEnum_m1TOPUP;

  static Serializer<TransactionQuoteRequestServiceCodeEnum> get serializer => _$transactionQuoteRequestServiceCodeEnumSerializer;

  const TransactionQuoteRequestServiceCodeEnum._(String name): super(name);

  static BuiltSet<TransactionQuoteRequestServiceCodeEnum> get values => _$transactionQuoteRequestServiceCodeEnumValues;
  static TransactionQuoteRequestServiceCodeEnum valueOf(String name) => _$transactionQuoteRequestServiceCodeEnumValueOf(name);
}

class TransactionQuoteRequestFundingSourceEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CARD_EMV')
  static const TransactionQuoteRequestFundingSourceEnum CARD_EMV = _$transactionQuoteRequestFundingSourceEnum_CARD_EMV;
  @BuiltValueEnumConst(wireName: r'CASH')
  static const TransactionQuoteRequestFundingSourceEnum CASH = _$transactionQuoteRequestFundingSourceEnum_CASH;
  @BuiltValueEnumConst(wireName: r'DUITNOW_MOBILE')
  static const TransactionQuoteRequestFundingSourceEnum DUITNOW_MOBILE = _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MOBILE;
  @BuiltValueEnumConst(wireName: r'DUITNOW_MYKAD')
  static const TransactionQuoteRequestFundingSourceEnum DUITNOW_MYKAD = _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MYKAD;
  @BuiltValueEnumConst(wireName: r'DUITNOW_BRN')
  static const TransactionQuoteRequestFundingSourceEnum DUITNOW_BRN = _$transactionQuoteRequestFundingSourceEnum_DUITNOW_BRN;
  @BuiltValueEnumConst(wireName: r'MYKAD_BIOMETRIC')
  static const TransactionQuoteRequestFundingSourceEnum MYKAD_BIOMETRIC = _$transactionQuoteRequestFundingSourceEnum_MYKAD_BIOMETRIC;
  @BuiltValueEnumConst(wireName: r'DUITNOW_QR')
  static const TransactionQuoteRequestFundingSourceEnum DUITNOW_QR = _$transactionQuoteRequestFundingSourceEnum_DUITNOW_QR;

  static Serializer<TransactionQuoteRequestFundingSourceEnum> get serializer => _$transactionQuoteRequestFundingSourceEnumSerializer;

  const TransactionQuoteRequestFundingSourceEnum._(String name): super(name);

  static BuiltSet<TransactionQuoteRequestFundingSourceEnum> get values => _$transactionQuoteRequestFundingSourceEnumValues;
  static TransactionQuoteRequestFundingSourceEnum valueOf(String name) => _$transactionQuoteRequestFundingSourceEnumValueOf(name);
}

class TransactionQuoteRequestBillerRoutingEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ON_US')
  static const TransactionQuoteRequestBillerRoutingEnum ON_US = _$transactionQuoteRequestBillerRoutingEnum_ON_US;
  @BuiltValueEnumConst(wireName: r'OFF_US')
  static const TransactionQuoteRequestBillerRoutingEnum OFF_US = _$transactionQuoteRequestBillerRoutingEnum_OFF_US;

  static Serializer<TransactionQuoteRequestBillerRoutingEnum> get serializer => _$transactionQuoteRequestBillerRoutingEnumSerializer;

  const TransactionQuoteRequestBillerRoutingEnum._(String name): super(name);

  static BuiltSet<TransactionQuoteRequestBillerRoutingEnum> get values => _$transactionQuoteRequestBillerRoutingEnumValues;
  static TransactionQuoteRequestBillerRoutingEnum valueOf(String name) => _$transactionQuoteRequestBillerRoutingEnumValueOf(name);
}

