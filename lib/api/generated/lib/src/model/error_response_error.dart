//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'error_response_error.g.dart';

/// ErrorResponseError
///
/// Properties:
/// * [code] 
/// * [message] 
/// * [actionCode] 
/// * [traceId] 
/// * [timestamp] 
@BuiltValue()
abstract class ErrorResponseError implements Built<ErrorResponseError, ErrorResponseErrorBuilder> {
  @BuiltValueField(wireName: r'code')
  String? get code;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'action_code')
  ErrorResponseErrorActionCodeEnum? get actionCode;
  // enum actionCodeEnum {  DECLINE,  RETRY,  REVIEW,  };

  @BuiltValueField(wireName: r'trace_id')
  String? get traceId;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  ErrorResponseError._();

  factory ErrorResponseError([void updates(ErrorResponseErrorBuilder b)]) = _$ErrorResponseError;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ErrorResponseErrorBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ErrorResponseError> get serializer => _$ErrorResponseErrorSerializer();
}

class _$ErrorResponseErrorSerializer implements PrimitiveSerializer<ErrorResponseError> {
  @override
  final Iterable<Type> types = const [ErrorResponseError, _$ErrorResponseError];

  @override
  final String wireName = r'ErrorResponseError';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ErrorResponseError object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.code != null) {
      yield r'code';
      yield serializers.serialize(
        object.code,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.actionCode != null) {
      yield r'action_code';
      yield serializers.serialize(
        object.actionCode,
        specifiedType: const FullType(ErrorResponseErrorActionCodeEnum),
      );
    }
    if (object.traceId != null) {
      yield r'trace_id';
      yield serializers.serialize(
        object.traceId,
        specifiedType: const FullType(String),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ErrorResponseError object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ErrorResponseErrorBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.code = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'action_code':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ErrorResponseErrorActionCodeEnum),
          ) as ErrorResponseErrorActionCodeEnum;
          result.actionCode = valueDes;
          break;
        case r'trace_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.traceId = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ErrorResponseError deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ErrorResponseErrorBuilder();
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

class ErrorResponseErrorActionCodeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'DECLINE')
  static const ErrorResponseErrorActionCodeEnum DECLINE = _$errorResponseErrorActionCodeEnum_DECLINE;
  @BuiltValueEnumConst(wireName: r'RETRY')
  static const ErrorResponseErrorActionCodeEnum RETRY = _$errorResponseErrorActionCodeEnum_RETRY;
  @BuiltValueEnumConst(wireName: r'REVIEW')
  static const ErrorResponseErrorActionCodeEnum REVIEW = _$errorResponseErrorActionCodeEnum_REVIEW;

  static Serializer<ErrorResponseErrorActionCodeEnum> get serializer => _$errorResponseErrorActionCodeEnumSerializer;

  const ErrorResponseErrorActionCodeEnum._(String name): super(name);

  static BuiltSet<ErrorResponseErrorActionCodeEnum> get values => _$errorResponseErrorActionCodeEnumValues;
  static ErrorResponseErrorActionCodeEnum valueOf(String name) => _$errorResponseErrorActionCodeEnumValueOf(name);
}

