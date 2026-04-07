//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_response.g.dart';

/// ResetPasswordResponse
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class ResetPasswordResponse implements Built<ResetPasswordResponse, ResetPasswordResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  ResetPasswordResponse._();

  factory ResetPasswordResponse([void updates(ResetPasswordResponseBuilder b)]) = _$ResetPasswordResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordResponse> get serializer => _$ResetPasswordResponseSerializer();
}

class _$ResetPasswordResponseSerializer implements PrimitiveSerializer<ResetPasswordResponse> {
  @override
  final Iterable<Type> types = const [ResetPasswordResponse, _$ResetPasswordResponse];

  @override
  final String wireName = r'ResetPasswordResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResetPasswordResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordResponseBuilder();
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

