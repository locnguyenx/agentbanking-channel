//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'topup_external_request.g.dart';

/// TopupExternalRequest
///
/// Properties:
/// * [telco] - Telco provider
/// * [phoneNumber] - Mobile number (MSISDN format)
/// * [amount] - Top-up amount in MYR
/// * [currency] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class TopupExternalRequest implements Built<TopupExternalRequest, TopupExternalRequestBuilder> {
  /// Telco provider
  @BuiltValueField(wireName: r'telco')
  TopupExternalRequestTelcoEnum get telco;
  // enum telcoEnum {  CELCOM,  M1,  UMOBILE,  MAXIS,  DIGI,  };

  /// Mobile number (MSISDN format)
  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  /// Top-up amount in MYR
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'currency')
  TopupExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  TopupExternalRequest._();

  factory TopupExternalRequest([void updates(TopupExternalRequestBuilder b)]) = _$TopupExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TopupExternalRequestBuilder b) => b
      ..currency = TopupExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<TopupExternalRequest> get serializer => _$TopupExternalRequestSerializer();
}

class _$TopupExternalRequestSerializer implements PrimitiveSerializer<TopupExternalRequest> {
  @override
  final Iterable<Type> types = const [TopupExternalRequest, _$TopupExternalRequest];

  @override
  final String wireName = r'TopupExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TopupExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'telco';
    yield serializers.serialize(
      object.telco,
      specifiedType: const FullType(TopupExternalRequestTelcoEnum),
    );
    yield r'phoneNumber';
    yield serializers.serialize(
      object.phoneNumber,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(TopupExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TopupExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TopupExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'telco':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TopupExternalRequestTelcoEnum),
          ) as TopupExternalRequestTelcoEnum;
          result.telco = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phoneNumber = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TopupExternalRequestCurrencyEnum),
          ) as TopupExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TopupExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TopupExternalRequestBuilder();
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

class TopupExternalRequestTelcoEnum extends EnumClass {

  /// Telco provider
  @BuiltValueEnumConst(wireName: r'CELCOM')
  static const TopupExternalRequestTelcoEnum CELCOM = _$topupExternalRequestTelcoEnum_CELCOM;
  /// Telco provider
  @BuiltValueEnumConst(wireName: r'M1')
  static const TopupExternalRequestTelcoEnum m1 = _$topupExternalRequestTelcoEnum_m1;
  /// Telco provider
  @BuiltValueEnumConst(wireName: r'UMOBILE')
  static const TopupExternalRequestTelcoEnum UMOBILE = _$topupExternalRequestTelcoEnum_UMOBILE;
  /// Telco provider
  @BuiltValueEnumConst(wireName: r'MAXIS')
  static const TopupExternalRequestTelcoEnum MAXIS = _$topupExternalRequestTelcoEnum_MAXIS;
  /// Telco provider
  @BuiltValueEnumConst(wireName: r'DIGI')
  static const TopupExternalRequestTelcoEnum DIGI = _$topupExternalRequestTelcoEnum_DIGI;

  static Serializer<TopupExternalRequestTelcoEnum> get serializer => _$topupExternalRequestTelcoEnumSerializer;

  const TopupExternalRequestTelcoEnum._(String name): super(name);

  static BuiltSet<TopupExternalRequestTelcoEnum> get values => _$topupExternalRequestTelcoEnumValues;
  static TopupExternalRequestTelcoEnum valueOf(String name) => _$topupExternalRequestTelcoEnumValueOf(name);
}

class TopupExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const TopupExternalRequestCurrencyEnum MYR = _$topupExternalRequestCurrencyEnum_MYR;

  static Serializer<TopupExternalRequestCurrencyEnum> get serializer => _$topupExternalRequestCurrencyEnumSerializer;

  const TopupExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<TopupExternalRequestCurrencyEnum> get values => _$topupExternalRequestCurrencyEnumValues;
  static TopupExternalRequestCurrencyEnum valueOf(String name) => _$topupExternalRequestCurrencyEnumValueOf(name);
}

