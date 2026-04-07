//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'retail_cashback_external_request.g.dart';

/// RetailCashbackExternalRequest
///
/// Properties:
/// * [merchantId] 
/// * [cashBackAmount] 
/// * [cardData] 
/// * [pinBlock] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class RetailCashbackExternalRequest implements Built<RetailCashbackExternalRequest, RetailCashbackExternalRequestBuilder> {
  @BuiltValueField(wireName: r'merchantId')
  String get merchantId;

  @BuiltValueField(wireName: r'cashBackAmount')
  String get cashBackAmount;

  @BuiltValueField(wireName: r'cardData')
  String? get cardData;

  @BuiltValueField(wireName: r'pinBlock')
  String? get pinBlock;

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  RetailCashbackExternalRequest._();

  factory RetailCashbackExternalRequest([void updates(RetailCashbackExternalRequestBuilder b)]) = _$RetailCashbackExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RetailCashbackExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RetailCashbackExternalRequest> get serializer => _$RetailCashbackExternalRequestSerializer();
}

class _$RetailCashbackExternalRequestSerializer implements PrimitiveSerializer<RetailCashbackExternalRequest> {
  @override
  final Iterable<Type> types = const [RetailCashbackExternalRequest, _$RetailCashbackExternalRequest];

  @override
  final String wireName = r'RetailCashbackExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RetailCashbackExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'merchantId';
    yield serializers.serialize(
      object.merchantId,
      specifiedType: const FullType(String),
    );
    yield r'cashBackAmount';
    yield serializers.serialize(
      object.cashBackAmount,
      specifiedType: const FullType(String),
    );
    if (object.cardData != null) {
      yield r'cardData';
      yield serializers.serialize(
        object.cardData,
        specifiedType: const FullType(String),
      );
    }
    if (object.pinBlock != null) {
      yield r'pinBlock';
      yield serializers.serialize(
        object.pinBlock,
        specifiedType: const FullType(String),
      );
    }
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RetailCashbackExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RetailCashbackExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'merchantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.merchantId = valueDes;
          break;
        case r'cashBackAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cashBackAmount = valueDes;
          break;
        case r'cardData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cardData = valueDes;
          break;
        case r'pinBlock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pinBlock = valueDes;
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
  RetailCashbackExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RetailCashbackExternalRequestBuilder();
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

