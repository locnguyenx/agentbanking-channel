//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'card_auth_request.g.dart';

/// CardAuthRequest
///
/// Properties:
/// * [internalTransactionId] 
/// * [pan] 
/// * [amount] 
@BuiltValue()
abstract class CardAuthRequest implements Built<CardAuthRequest, CardAuthRequestBuilder> {
  @BuiltValueField(wireName: r'internalTransactionId')
  String get internalTransactionId;

  @BuiltValueField(wireName: r'pan')
  String get pan;

  @BuiltValueField(wireName: r'amount')
  num get amount;

  CardAuthRequest._();

  factory CardAuthRequest([void updates(CardAuthRequestBuilder b)]) = _$CardAuthRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CardAuthRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CardAuthRequest> get serializer => _$CardAuthRequestSerializer();
}

class _$CardAuthRequestSerializer implements PrimitiveSerializer<CardAuthRequest> {
  @override
  final Iterable<Type> types = const [CardAuthRequest, _$CardAuthRequest];

  @override
  final String wireName = r'CardAuthRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CardAuthRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'internalTransactionId';
    yield serializers.serialize(
      object.internalTransactionId,
      specifiedType: const FullType(String),
    );
    yield r'pan';
    yield serializers.serialize(
      object.pan,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CardAuthRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CardAuthRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'internalTransactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.internalTransactionId = valueDes;
          break;
        case r'pan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pan = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CardAuthRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CardAuthRequestBuilder();
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

