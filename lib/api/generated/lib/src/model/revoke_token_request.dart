//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'revoke_token_request.g.dart';

/// RevokeTokenRequest
///
/// Properties:
/// * [token] - Optional. If not provided, revokes all sessions for the current user.
@BuiltValue()
abstract class RevokeTokenRequest implements Built<RevokeTokenRequest, RevokeTokenRequestBuilder> {
  /// Optional. If not provided, revokes all sessions for the current user.
  @BuiltValueField(wireName: r'token')
  String? get token;

  RevokeTokenRequest._();

  factory RevokeTokenRequest([void updates(RevokeTokenRequestBuilder b)]) = _$RevokeTokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RevokeTokenRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RevokeTokenRequest> get serializer => _$RevokeTokenRequestSerializer();
}

class _$RevokeTokenRequestSerializer implements PrimitiveSerializer<RevokeTokenRequest> {
  @override
  final Iterable<Type> types = const [RevokeTokenRequest, _$RevokeTokenRequest];

  @override
  final String wireName = r'RevokeTokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RevokeTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.token != null) {
      yield r'token';
      yield serializers.serialize(
        object.token,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RevokeTokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RevokeTokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RevokeTokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RevokeTokenRequestBuilder();
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

