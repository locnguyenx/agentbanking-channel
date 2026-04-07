//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/geo_location.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_external_request.g.dart';

/// WithdrawalExternalRequest
///
/// Properties:
/// * [amount] - Transaction amount in MYR
/// * [currency] 
/// * [idempotencyKey] - Unique key to prevent duplicate transactions
/// * [customerCard] - Customer card number (PAN)
/// * [customerPin] - Customer PIN (4-6 digits)
/// * [location] 
@BuiltValue()
abstract class WithdrawalExternalRequest implements Built<WithdrawalExternalRequest, WithdrawalExternalRequestBuilder> {
  /// Transaction amount in MYR
  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'currency')
  WithdrawalExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  /// Unique key to prevent duplicate transactions
  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  /// Customer card number (PAN)
  @BuiltValueField(wireName: r'customerCard')
  String get customerCard;

  /// Customer PIN (4-6 digits)
  @BuiltValueField(wireName: r'customerPin')
  String get customerPin;

  @BuiltValueField(wireName: r'location')
  GeoLocation? get location;

  WithdrawalExternalRequest._();

  factory WithdrawalExternalRequest([void updates(WithdrawalExternalRequestBuilder b)]) = _$WithdrawalExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalExternalRequestBuilder b) => b
      ..currency = WithdrawalExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<WithdrawalExternalRequest> get serializer => _$WithdrawalExternalRequestSerializer();
}

class _$WithdrawalExternalRequestSerializer implements PrimitiveSerializer<WithdrawalExternalRequest> {
  @override
  final Iterable<Type> types = const [WithdrawalExternalRequest, _$WithdrawalExternalRequest];

  @override
  final String wireName = r'WithdrawalExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WithdrawalExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(WithdrawalExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'customerCard';
    yield serializers.serialize(
      object.customerCard,
      specifiedType: const FullType(String),
    );
    yield r'customerPin';
    yield serializers.serialize(
      object.customerPin,
      specifiedType: const FullType(String),
    );
    if (object.location != null) {
      yield r'location';
      yield serializers.serialize(
        object.location,
        specifiedType: const FullType(GeoLocation),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WithdrawalExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(WithdrawalExternalRequestCurrencyEnum),
          ) as WithdrawalExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerCard':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerCard = valueDes;
          break;
        case r'customerPin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerPin = valueDes;
          break;
        case r'location':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(GeoLocation),
          ) as GeoLocation;
          result.location.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WithdrawalExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalExternalRequestBuilder();
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

class WithdrawalExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const WithdrawalExternalRequestCurrencyEnum MYR = _$withdrawalExternalRequestCurrencyEnum_MYR;

  static Serializer<WithdrawalExternalRequestCurrencyEnum> get serializer => _$withdrawalExternalRequestCurrencyEnumSerializer;

  const WithdrawalExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<WithdrawalExternalRequestCurrencyEnum> get values => _$withdrawalExternalRequestCurrencyEnumValues;
  static WithdrawalExternalRequestCurrencyEnum valueOf(String name) => _$withdrawalExternalRequestCurrencyEnumValueOf(name);
}

