//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'jom_pay_external_request.g.dart';

/// JomPayExternalRequest
///
/// Properties:
/// * [billerCode] - JomPay biller code
/// * [ref1] - JomPay reference 1 (bill account)
/// * [ref2] - JomPay reference 2 (optional)
/// * [amount] - Payment amount in MYR
/// * [currency] 
/// * [idempotencyKey] 
/// * [customerMobile] 
@BuiltValue()
abstract class JomPayExternalRequest implements Built<JomPayExternalRequest, JomPayExternalRequestBuilder> {
  /// JomPay biller code
  @BuiltValueField(wireName: r'billerCode')
  String get billerCode;

  /// JomPay reference 1 (bill account)
  @BuiltValueField(wireName: r'ref1')
  String get ref1;

  /// JomPay reference 2 (optional)
  @BuiltValueField(wireName: r'ref2')
  String? get ref2;

  /// Payment amount in MYR
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  JomPayExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  @BuiltValueField(wireName: r'customerMobile')
  String? get customerMobile;

  JomPayExternalRequest._();

  factory JomPayExternalRequest([void updates(JomPayExternalRequestBuilder b)]) = _$JomPayExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(JomPayExternalRequestBuilder b) => b
      ..currency = JomPayExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<JomPayExternalRequest> get serializer => _$JomPayExternalRequestSerializer();
}

class _$JomPayExternalRequestSerializer implements PrimitiveSerializer<JomPayExternalRequest> {
  @override
  final Iterable<Type> types = const [JomPayExternalRequest, _$JomPayExternalRequest];

  @override
  final String wireName = r'JomPayExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    JomPayExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'billerCode';
    yield serializers.serialize(
      object.billerCode,
      specifiedType: const FullType(String),
    );
    yield r'ref1';
    yield serializers.serialize(
      object.ref1,
      specifiedType: const FullType(String),
    );
    if (object.ref2 != null) {
      yield r'ref2';
      yield serializers.serialize(
        object.ref2,
        specifiedType: const FullType(String),
      );
    }
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(JomPayExternalRequestCurrencyEnum),
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
    JomPayExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required JomPayExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'billerCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.billerCode = valueDes;
          break;
        case r'ref1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref1 = valueDes;
          break;
        case r'ref2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref2 = valueDes;
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
            specifiedType: const FullType(JomPayExternalRequestCurrencyEnum),
          ) as JomPayExternalRequestCurrencyEnum;
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
  JomPayExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = JomPayExternalRequestBuilder();
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

class JomPayExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const JomPayExternalRequestCurrencyEnum MYR = _$jomPayExternalRequestCurrencyEnum_MYR;

  static Serializer<JomPayExternalRequestCurrencyEnum> get serializer => _$jomPayExternalRequestCurrencyEnumSerializer;

  const JomPayExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<JomPayExternalRequestCurrencyEnum> get values => _$jomPayExternalRequestCurrencyEnumValues;
  static JomPayExternalRequestCurrencyEnum valueOf(String name) => _$jomPayExternalRequestCurrencyEnumValueOf(name);
}

