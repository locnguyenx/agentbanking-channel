//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submission_response.g.dart';

/// SubmissionResponse
///
/// Properties:
/// * [applicationId] 
/// * [status] 
/// * [message] 
@BuiltValue()
abstract class SubmissionResponse implements Built<SubmissionResponse, SubmissionResponseBuilder> {
  @BuiltValueField(wireName: r'applicationId')
  String? get applicationId;

  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'message')
  String? get message;

  SubmissionResponse._();

  factory SubmissionResponse([void updates(SubmissionResponseBuilder b)]) = _$SubmissionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmissionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmissionResponse> get serializer => _$SubmissionResponseSerializer();
}

class _$SubmissionResponseSerializer implements PrimitiveSerializer<SubmissionResponse> {
  @override
  final Iterable<Type> types = const [SubmissionResponse, _$SubmissionResponse];

  @override
  final String wireName = r'SubmissionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmissionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.applicationId != null) {
      yield r'applicationId';
      yield serializers.serialize(
        object.applicationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
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
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmissionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmissionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'applicationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicationId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
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
  SubmissionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmissionResponseBuilder();
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

