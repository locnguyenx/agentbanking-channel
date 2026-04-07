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
/// * [serviceCode] 
/// * [amount] 
/// * [agentId] 
/// * [fundingSource] 
/// * [billerRouting] 
@BuiltValue()
abstract class TransactionQuoteRequest implements Built<TransactionQuoteRequest, TransactionQuoteRequestBuilder> {
  @BuiltValueField(wireName: r'serviceCode')
  String get serviceCode;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'agentId')
  String get agentId;

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
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'agentId';
    yield serializers.serialize(
      object.agentId,
      specifiedType: const FullType(String),
    );
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
            specifiedType: const FullType(String),
          ) as String;
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

