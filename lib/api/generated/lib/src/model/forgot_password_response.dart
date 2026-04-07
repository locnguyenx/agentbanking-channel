//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'forgot_password_response.g.dart';

/// ForgotPasswordResponse
///
/// Properties:
/// * [message] 
@BuiltValue()
abstract class ForgotPasswordResponse implements Built<ForgotPasswordResponse, ForgotPasswordResponseBuilder> {
  @BuiltValueField(wireName: r'message')
  String? get message;

  ForgotPasswordResponse._();

  factory ForgotPasswordResponse([void updates(ForgotPasswordResponseBuilder b)]) = _$ForgotPasswordResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ForgotPasswordResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ForgotPasswordResponse> get serializer => _$ForgotPasswordResponseSerializer();
}

class _$ForgotPasswordResponseSerializer implements PrimitiveSerializer<ForgotPasswordResponse> {
  @override
  final Iterable<Type> types = const [ForgotPasswordResponse, _$ForgotPasswordResponse];

  @override
  final String wireName = r'ForgotPasswordResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ForgotPasswordResponse object, {
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
    ForgotPasswordResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ForgotPasswordResponseBuilder result,
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
  ForgotPasswordResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ForgotPasswordResponseBuilder();
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

