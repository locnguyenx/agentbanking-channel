//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'duit_now_external_request.g.dart';

/// DuitNowExternalRequest
///
/// Properties:
/// * [amount] 
/// * [currency] 
/// * [idempotencyKey] 
/// * [proxyType] 
/// * [proxyValue] 
/// * [recipientName] 
@BuiltValue()
abstract class DuitNowExternalRequest implements Built<DuitNowExternalRequest, DuitNowExternalRequestBuilder> {
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  DuitNowExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'proxyType')
  DuitNowExternalRequestProxyTypeEnum get proxyType;
  // enum proxyTypeEnum {  IC,  PHONE,  EMAIL,  TGAN,  };

  @BuiltValueField(wireName: r'proxyValue')
  String get proxyValue;

  @BuiltValueField(wireName: r'recipientName')
  String? get recipientName;

  DuitNowExternalRequest._();

  factory DuitNowExternalRequest([void updates(DuitNowExternalRequestBuilder b)]) = _$DuitNowExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DuitNowExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DuitNowExternalRequest> get serializer => _$DuitNowExternalRequestSerializer();
}

class _$DuitNowExternalRequestSerializer implements PrimitiveSerializer<DuitNowExternalRequest> {
  @override
  final Iterable<Type> types = const [DuitNowExternalRequest, _$DuitNowExternalRequest];

  @override
  final String wireName = r'DuitNowExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DuitNowExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(DuitNowExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'proxyType';
    yield serializers.serialize(
      object.proxyType,
      specifiedType: const FullType(DuitNowExternalRequestProxyTypeEnum),
    );
    yield r'proxyValue';
    yield serializers.serialize(
      object.proxyValue,
      specifiedType: const FullType(String),
    );
    if (object.recipientName != null) {
      yield r'recipientName';
      yield serializers.serialize(
        object.recipientName,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DuitNowExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DuitNowExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DuitNowExternalRequestCurrencyEnum),
          ) as DuitNowExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'proxyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DuitNowExternalRequestProxyTypeEnum),
          ) as DuitNowExternalRequestProxyTypeEnum;
          result.proxyType = valueDes;
          break;
        case r'proxyValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.proxyValue = valueDes;
          break;
        case r'recipientName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.recipientName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DuitNowExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DuitNowExternalRequestBuilder();
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

class DuitNowExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const DuitNowExternalRequestCurrencyEnum MYR = _$duitNowExternalRequestCurrencyEnum_MYR;

  static Serializer<DuitNowExternalRequestCurrencyEnum> get serializer => _$duitNowExternalRequestCurrencyEnumSerializer;

  const DuitNowExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<DuitNowExternalRequestCurrencyEnum> get values => _$duitNowExternalRequestCurrencyEnumValues;
  static DuitNowExternalRequestCurrencyEnum valueOf(String name) => _$duitNowExternalRequestCurrencyEnumValueOf(name);
}

class DuitNowExternalRequestProxyTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'IC')
  static const DuitNowExternalRequestProxyTypeEnum IC = _$duitNowExternalRequestProxyTypeEnum_IC;
  @BuiltValueEnumConst(wireName: r'PHONE')
  static const DuitNowExternalRequestProxyTypeEnum PHONE = _$duitNowExternalRequestProxyTypeEnum_PHONE;
  @BuiltValueEnumConst(wireName: r'EMAIL')
  static const DuitNowExternalRequestProxyTypeEnum EMAIL = _$duitNowExternalRequestProxyTypeEnum_EMAIL;
  @BuiltValueEnumConst(wireName: r'TGAN')
  static const DuitNowExternalRequestProxyTypeEnum TGAN = _$duitNowExternalRequestProxyTypeEnum_TGAN;

  static Serializer<DuitNowExternalRequestProxyTypeEnum> get serializer => _$duitNowExternalRequestProxyTypeEnumSerializer;

  const DuitNowExternalRequestProxyTypeEnum._(String name): super(name);

  static BuiltSet<DuitNowExternalRequestProxyTypeEnum> get values => _$duitNowExternalRequestProxyTypeEnumValues;
  static DuitNowExternalRequestProxyTypeEnum valueOf(String name) => _$duitNowExternalRequestProxyTypeEnumValueOf(name);
}

