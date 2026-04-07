//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checker_action_request.g.dart';

/// CheckerActionRequest
///
/// Properties:
/// * [reason] - Reason for approve/reject action
@BuiltValue()
abstract class CheckerActionRequest implements Built<CheckerActionRequest, CheckerActionRequestBuilder> {
  /// Reason for approve/reject action
  @BuiltValueField(wireName: r'reason')
  String get reason;

  CheckerActionRequest._();

  factory CheckerActionRequest([void updates(CheckerActionRequestBuilder b)]) = _$CheckerActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckerActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckerActionRequest> get serializer => _$CheckerActionRequestSerializer();
}

class _$CheckerActionRequestSerializer implements PrimitiveSerializer<CheckerActionRequest> {
  @override
  final Iterable<Type> types = const [CheckerActionRequest, _$CheckerActionRequest];

  @override
  final String wireName = r'CheckerActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CheckerActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckerActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CheckerActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckerActionRequestBuilder();
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

