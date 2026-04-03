//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/geo_location.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_external_request.g.dart';

/// DepositExternalRequest
///
/// Properties:
/// * [amount] - Transaction amount in MYR
/// * [currency]
/// * [idempotencyKey] - Unique key to prevent duplicate transactions
/// * [customerAccount] - Customer account number
/// * [customerName] - Customer full name
/// * [location]
@BuiltValue()
abstract class DepositExternalRequest
    implements Built<DepositExternalRequest, DepositExternalRequestBuilder> {
  /// Transaction amount in MYR
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  DepositExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  /// Unique key to prevent duplicate transactions
  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  /// Customer account number
  @BuiltValueField(wireName: r'customerAccount')
  String get customerAccount;

  /// Customer full name
  @BuiltValueField(wireName: r'customerName')
  String? get customerName;

  @BuiltValueField(wireName: r'location')
  GeoLocation? get location;

  DepositExternalRequest._();

  factory DepositExternalRequest(
          [void updates(DepositExternalRequestBuilder b)]) =
      _$DepositExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositExternalRequestBuilder b) =>
      b..currency = DepositExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositExternalRequest> get serializer =>
      _$DepositExternalRequestSerializer();
}

class _$DepositExternalRequestSerializer
    implements PrimitiveSerializer<DepositExternalRequest> {
  @override
  final Iterable<Type> types = const [
    DepositExternalRequest,
    _$DepositExternalRequest
  ];

  @override
  final String wireName = r'DepositExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositExternalRequest object, {
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
      specifiedType: const FullType(DepositExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    yield r'customerAccount';
    yield serializers.serialize(
      object.customerAccount,
      specifiedType: const FullType(String),
    );
    if (object.customerName != null) {
      yield r'customerName';
      yield serializers.serialize(
        object.customerName,
        specifiedType: const FullType(String),
      );
    }
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
    DepositExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositExternalRequestBuilder result,
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
            specifiedType: const FullType(DepositExternalRequestCurrencyEnum),
          ) as DepositExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerAccount = valueDes;
          break;
        case r'customerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerName = valueDes;
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
  DepositExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositExternalRequestBuilder();
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

class DepositExternalRequestCurrencyEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'MYR')
  static const DepositExternalRequestCurrencyEnum MYR =
      _$depositExternalRequestCurrencyEnum_MYR;

  static Serializer<DepositExternalRequestCurrencyEnum> get serializer =>
      _$depositExternalRequestCurrencyEnumSerializer;

  const DepositExternalRequestCurrencyEnum._(String name) : super(name);

  static BuiltSet<DepositExternalRequestCurrencyEnum> get values =>
      _$depositExternalRequestCurrencyEnumValues;
  static DepositExternalRequestCurrencyEnum valueOf(String name) =>
      _$depositExternalRequestCurrencyEnumValueOf(name);
}
