//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'force_resolve_request.g.dart';

/// ForceResolveRequest
///
/// Properties:
/// * [action] - Action to take - COMMIT to complete, REVERSE to cancel
/// * [reason] - Reason for force resolve
@BuiltValue()
abstract class ForceResolveRequest implements Built<ForceResolveRequest, ForceResolveRequestBuilder> {
  /// Action to take - COMMIT to complete, REVERSE to cancel
  @BuiltValueField(wireName: r'action')
  ForceResolveRequestActionEnum get action;
  // enum actionEnum {  COMMIT,  REVERSE,  };

  /// Reason for force resolve
  @BuiltValueField(wireName: r'reason')
  String get reason;

  ForceResolveRequest._();

  factory ForceResolveRequest([void updates(ForceResolveRequestBuilder b)]) = _$ForceResolveRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ForceResolveRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ForceResolveRequest> get serializer => _$ForceResolveRequestSerializer();
}

class _$ForceResolveRequestSerializer implements PrimitiveSerializer<ForceResolveRequest> {
  @override
  final Iterable<Type> types = const [ForceResolveRequest, _$ForceResolveRequest];

  @override
  final String wireName = r'ForceResolveRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ForceResolveRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(ForceResolveRequestActionEnum),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ForceResolveRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ForceResolveRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ForceResolveRequestActionEnum),
          ) as ForceResolveRequestActionEnum;
          result.action = valueDes;
          break;
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
  ForceResolveRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ForceResolveRequestBuilder();
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

class ForceResolveRequestActionEnum extends EnumClass {

  /// Action to take - COMMIT to complete, REVERSE to cancel
  @BuiltValueEnumConst(wireName: r'COMMIT')
  static const ForceResolveRequestActionEnum COMMIT = _$forceResolveRequestActionEnum_COMMIT;
  /// Action to take - COMMIT to complete, REVERSE to cancel
  @BuiltValueEnumConst(wireName: r'REVERSE')
  static const ForceResolveRequestActionEnum REVERSE = _$forceResolveRequestActionEnum_REVERSE;

  static Serializer<ForceResolveRequestActionEnum> get serializer => _$forceResolveRequestActionEnumSerializer;

  const ForceResolveRequestActionEnum._(String name): super(name);

  static BuiltSet<ForceResolveRequestActionEnum> get values => _$forceResolveRequestActionEnumValues;
  static ForceResolveRequestActionEnum valueOf(String name) => _$forceResolveRequestActionEnumValueOf(name);
}

