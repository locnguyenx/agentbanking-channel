//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'essp_external_request.g.dart';

/// EsspExternalRequest
///
/// Properties:
/// * [productCode] 
/// * [amount] 
/// * [currency] 
/// * [idempotencyKey] 
/// * [customerMobile] 
@BuiltValue()
abstract class EsspExternalRequest implements Built<EsspExternalRequest, EsspExternalRequestBuilder> {
  @BuiltValueField(wireName: r'productCode')
  String get productCode;

  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  EsspExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'customerMobile')
  String? get customerMobile;

  EsspExternalRequest._();

  factory EsspExternalRequest([void updates(EsspExternalRequestBuilder b)]) = _$EsspExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EsspExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EsspExternalRequest> get serializer => _$EsspExternalRequestSerializer();
}

class _$EsspExternalRequestSerializer implements PrimitiveSerializer<EsspExternalRequest> {
  @override
  final Iterable<Type> types = const [EsspExternalRequest, _$EsspExternalRequest];

  @override
  final String wireName = r'EsspExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EsspExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'productCode';
    yield serializers.serialize(
      object.productCode,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(EsspExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    if (object.customerMobile != null) {
      yield r'customerMobile';
      yield serializers.serialize(
        object.customerMobile,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    EsspExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EsspExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'productCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.productCode = valueDes;
          break;
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
            specifiedType: const FullType(EsspExternalRequestCurrencyEnum),
          ) as EsspExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerMobile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerMobile = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EsspExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EsspExternalRequestBuilder();
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

class EsspExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const EsspExternalRequestCurrencyEnum MYR = _$esspExternalRequestCurrencyEnum_MYR;

  static Serializer<EsspExternalRequestCurrencyEnum> get serializer => _$esspExternalRequestCurrencyEnumSerializer;

  const EsspExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<EsspExternalRequestCurrencyEnum> get values => _$esspExternalRequestCurrencyEnumValues;
  static EsspExternalRequestCurrencyEnum valueOf(String name) => _$esspExternalRequestCurrencyEnumValueOf(name);
}

