//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'retail_pin_purchase_external_request.g.dart';

/// RetailPinPurchaseExternalRequest
///
/// Properties:
/// * [productCode] 
/// * [amount] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class RetailPinPurchaseExternalRequest implements Built<RetailPinPurchaseExternalRequest, RetailPinPurchaseExternalRequestBuilder> {
  @BuiltValueField(wireName: r'productCode')
  String get productCode;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  RetailPinPurchaseExternalRequest._();

  factory RetailPinPurchaseExternalRequest([void updates(RetailPinPurchaseExternalRequestBuilder b)]) = _$RetailPinPurchaseExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RetailPinPurchaseExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RetailPinPurchaseExternalRequest> get serializer => _$RetailPinPurchaseExternalRequestSerializer();
}

class _$RetailPinPurchaseExternalRequestSerializer implements PrimitiveSerializer<RetailPinPurchaseExternalRequest> {
  @override
  final Iterable<Type> types = const [RetailPinPurchaseExternalRequest, _$RetailPinPurchaseExternalRequest];

  @override
  final String wireName = r'RetailPinPurchaseExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RetailPinPurchaseExternalRequest object, {
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
      specifiedType: const FullType(String),
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
    RetailPinPurchaseExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RetailPinPurchaseExternalRequestBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
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
  RetailPinPurchaseExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RetailPinPurchaseExternalRequestBuilder();
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

