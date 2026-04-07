//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fee_config_request.g.dart';

/// FeeConfigRequest
///
/// Properties:
/// * [agentType] 
/// * [transactionType] 
/// * [feeType] 
/// * [feeAmount] 
/// * [percentage] 
/// * [minFee] 
/// * [maxFee] 
/// * [currency] 
/// * [effectiveFrom] 
/// * [effectiveTo] 
@BuiltValue()
abstract class FeeConfigRequest implements Built<FeeConfigRequest, FeeConfigRequestBuilder> {
  @BuiltValueField(wireName: r'agentType')
  FeeConfigRequestAgentTypeEnum get agentType;
  // enum agentTypeEnum {  MICRO,  STANDARD,  PREMIER,  };

  @BuiltValueField(wireName: r'transactionType')
  FeeConfigRequestTransactionTypeEnum get transactionType;
  // enum transactionTypeEnum {  CASH_WITHDRAWAL,  CASH_DEPOSIT,  BALANCE_INQUIRY,  DUITNOW_TRANSFER,  JOMPAY,  CELCOM_TOPUP,  M1_TOPUP,  ESSP_PURCHASE,  PIN_PURCHASE,  };

  @BuiltValueField(wireName: r'feeType')
  FeeConfigRequestFeeTypeEnum get feeType;
  // enum feeTypeEnum {  FIXED,  PERCENTAGE,  };

  @BuiltValueField(wireName: r'feeAmount')
  String? get feeAmount;

  @BuiltValueField(wireName: r'percentage')
  String? get percentage;

  @BuiltValueField(wireName: r'minFee')
  String? get minFee;

  @BuiltValueField(wireName: r'maxFee')
  String? get maxFee;

  @BuiltValueField(wireName: r'currency')
  FeeConfigRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'effectiveFrom')
  DateTime get effectiveFrom;

  @BuiltValueField(wireName: r'effectiveTo')
  DateTime? get effectiveTo;

  FeeConfigRequest._();

  factory FeeConfigRequest([void updates(FeeConfigRequestBuilder b)]) = _$FeeConfigRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FeeConfigRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FeeConfigRequest> get serializer => _$FeeConfigRequestSerializer();
}

class _$FeeConfigRequestSerializer implements PrimitiveSerializer<FeeConfigRequest> {
  @override
  final Iterable<Type> types = const [FeeConfigRequest, _$FeeConfigRequest];

  @override
  final String wireName = r'FeeConfigRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FeeConfigRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'agentType';
    yield serializers.serialize(
      object.agentType,
      specifiedType: const FullType(FeeConfigRequestAgentTypeEnum),
    );
    yield r'transactionType';
    yield serializers.serialize(
      object.transactionType,
      specifiedType: const FullType(FeeConfigRequestTransactionTypeEnum),
    );
    yield r'feeType';
    yield serializers.serialize(
      object.feeType,
      specifiedType: const FullType(FeeConfigRequestFeeTypeEnum),
    );
    if (object.feeAmount != null) {
      yield r'feeAmount';
      yield serializers.serialize(
        object.feeAmount,
        specifiedType: const FullType(String),
      );
    }
    if (object.percentage != null) {
      yield r'percentage';
      yield serializers.serialize(
        object.percentage,
        specifiedType: const FullType(String),
      );
    }
    if (object.minFee != null) {
      yield r'minFee';
      yield serializers.serialize(
        object.minFee,
        specifiedType: const FullType(String),
      );
    }
    if (object.maxFee != null) {
      yield r'maxFee';
      yield serializers.serialize(
        object.maxFee,
        specifiedType: const FullType(String),
      );
    }
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(FeeConfigRequestCurrencyEnum),
    );
    yield r'effectiveFrom';
    yield serializers.serialize(
      object.effectiveFrom,
      specifiedType: const FullType(DateTime),
    );
    if (object.effectiveTo != null) {
      yield r'effectiveTo';
      yield serializers.serialize(
        object.effectiveTo,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    FeeConfigRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FeeConfigRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agentType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeeConfigRequestAgentTypeEnum),
          ) as FeeConfigRequestAgentTypeEnum;
          result.agentType = valueDes;
          break;
        case r'transactionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeeConfigRequestTransactionTypeEnum),
          ) as FeeConfigRequestTransactionTypeEnum;
          result.transactionType = valueDes;
          break;
        case r'feeType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeeConfigRequestFeeTypeEnum),
          ) as FeeConfigRequestFeeTypeEnum;
          result.feeType = valueDes;
          break;
        case r'feeAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.feeAmount = valueDes;
          break;
        case r'percentage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.percentage = valueDes;
          break;
        case r'minFee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.minFee = valueDes;
          break;
        case r'maxFee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.maxFee = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FeeConfigRequestCurrencyEnum),
          ) as FeeConfigRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'effectiveFrom':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveFrom = valueDes;
          break;
        case r'effectiveTo':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.effectiveTo = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FeeConfigRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FeeConfigRequestBuilder();
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

class FeeConfigRequestAgentTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MICRO')
  static const FeeConfigRequestAgentTypeEnum MICRO = _$feeConfigRequestAgentTypeEnum_MICRO;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const FeeConfigRequestAgentTypeEnum STANDARD = _$feeConfigRequestAgentTypeEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const FeeConfigRequestAgentTypeEnum PREMIER = _$feeConfigRequestAgentTypeEnum_PREMIER;

  static Serializer<FeeConfigRequestAgentTypeEnum> get serializer => _$feeConfigRequestAgentTypeEnumSerializer;

  const FeeConfigRequestAgentTypeEnum._(String name): super(name);

  static BuiltSet<FeeConfigRequestAgentTypeEnum> get values => _$feeConfigRequestAgentTypeEnumValues;
  static FeeConfigRequestAgentTypeEnum valueOf(String name) => _$feeConfigRequestAgentTypeEnumValueOf(name);
}

class FeeConfigRequestTransactionTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'CASH_WITHDRAWAL')
  static const FeeConfigRequestTransactionTypeEnum CASH_WITHDRAWAL = _$feeConfigRequestTransactionTypeEnum_CASH_WITHDRAWAL;
  @BuiltValueEnumConst(wireName: r'CASH_DEPOSIT')
  static const FeeConfigRequestTransactionTypeEnum CASH_DEPOSIT = _$feeConfigRequestTransactionTypeEnum_CASH_DEPOSIT;
  @BuiltValueEnumConst(wireName: r'BALANCE_INQUIRY')
  static const FeeConfigRequestTransactionTypeEnum BALANCE_INQUIRY = _$feeConfigRequestTransactionTypeEnum_BALANCE_INQUIRY;
  @BuiltValueEnumConst(wireName: r'DUITNOW_TRANSFER')
  static const FeeConfigRequestTransactionTypeEnum DUITNOW_TRANSFER = _$feeConfigRequestTransactionTypeEnum_DUITNOW_TRANSFER;
  @BuiltValueEnumConst(wireName: r'JOMPAY')
  static const FeeConfigRequestTransactionTypeEnum JOMPAY = _$feeConfigRequestTransactionTypeEnum_JOMPAY;
  @BuiltValueEnumConst(wireName: r'CELCOM_TOPUP')
  static const FeeConfigRequestTransactionTypeEnum CELCOM_TOPUP = _$feeConfigRequestTransactionTypeEnum_CELCOM_TOPUP;
  @BuiltValueEnumConst(wireName: r'M1_TOPUP')
  static const FeeConfigRequestTransactionTypeEnum m1TOPUP = _$feeConfigRequestTransactionTypeEnum_m1TOPUP;
  @BuiltValueEnumConst(wireName: r'ESSP_PURCHASE')
  static const FeeConfigRequestTransactionTypeEnum ESSP_PURCHASE = _$feeConfigRequestTransactionTypeEnum_ESSP_PURCHASE;
  @BuiltValueEnumConst(wireName: r'PIN_PURCHASE')
  static const FeeConfigRequestTransactionTypeEnum PIN_PURCHASE = _$feeConfigRequestTransactionTypeEnum_PIN_PURCHASE;

  static Serializer<FeeConfigRequestTransactionTypeEnum> get serializer => _$feeConfigRequestTransactionTypeEnumSerializer;

  const FeeConfigRequestTransactionTypeEnum._(String name): super(name);

  static BuiltSet<FeeConfigRequestTransactionTypeEnum> get values => _$feeConfigRequestTransactionTypeEnumValues;
  static FeeConfigRequestTransactionTypeEnum valueOf(String name) => _$feeConfigRequestTransactionTypeEnumValueOf(name);
}

class FeeConfigRequestFeeTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'FIXED')
  static const FeeConfigRequestFeeTypeEnum FIXED = _$feeConfigRequestFeeTypeEnum_FIXED;
  @BuiltValueEnumConst(wireName: r'PERCENTAGE')
  static const FeeConfigRequestFeeTypeEnum PERCENTAGE = _$feeConfigRequestFeeTypeEnum_PERCENTAGE;

  static Serializer<FeeConfigRequestFeeTypeEnum> get serializer => _$feeConfigRequestFeeTypeEnumSerializer;

  const FeeConfigRequestFeeTypeEnum._(String name): super(name);

  static BuiltSet<FeeConfigRequestFeeTypeEnum> get values => _$feeConfigRequestFeeTypeEnumValues;
  static FeeConfigRequestFeeTypeEnum valueOf(String name) => _$feeConfigRequestFeeTypeEnumValueOf(name);
}

class FeeConfigRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const FeeConfigRequestCurrencyEnum MYR = _$feeConfigRequestCurrencyEnum_MYR;

  static Serializer<FeeConfigRequestCurrencyEnum> get serializer => _$feeConfigRequestCurrencyEnumSerializer;

  const FeeConfigRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<FeeConfigRequestCurrencyEnum> get values => _$feeConfigRequestCurrencyEnumValues;
  static FeeConfigRequestCurrencyEnum valueOf(String name) => _$feeConfigRequestCurrencyEnumValueOf(name);
}

