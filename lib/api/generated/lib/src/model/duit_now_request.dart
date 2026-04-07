//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'duit_now_request.g.dart';

/// DuitNowRequest
///
/// Properties:
/// * [internalTransactionId] 
/// * [proxyType] 
/// * [proxyValue] 
/// * [amount] 
@BuiltValue()
abstract class DuitNowRequest implements Built<DuitNowRequest, DuitNowRequestBuilder> {
  @BuiltValueField(wireName: r'internalTransactionId')
  String get internalTransactionId;

  @BuiltValueField(wireName: r'proxyType')
  String get proxyType;

  @BuiltValueField(wireName: r'proxyValue')
  String get proxyValue;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  DuitNowRequest._();

  factory DuitNowRequest([void updates(DuitNowRequestBuilder b)]) = _$DuitNowRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DuitNowRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DuitNowRequest> get serializer => _$DuitNowRequestSerializer();
}

class _$DuitNowRequestSerializer implements PrimitiveSerializer<DuitNowRequest> {
  @override
  final Iterable<Type> types = const [DuitNowRequest, _$DuitNowRequest];

  @override
  final String wireName = r'DuitNowRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DuitNowRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'internalTransactionId';
    yield serializers.serialize(
      object.internalTransactionId,
      specifiedType: const FullType(String),
    );
    yield r'proxyType';
    yield serializers.serialize(
      object.proxyType,
      specifiedType: const FullType(String),
    );
    yield r'proxyValue';
    yield serializers.serialize(
      object.proxyValue,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DuitNowRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DuitNowRequestBuilder result,
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
        case r'proxyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.proxyType = valueDes;
          break;
        case r'proxyValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.proxyValue = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
  DuitNowRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DuitNowRequestBuilder();
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

