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
/// * [action] - Action to take - RETRY to retry, ABORT to cancel
/// * [reason] - Reason for force resolve
/// * [adminId] - ID of the admin performing the action
@BuiltValue()
abstract class ForceResolveRequest implements Built<ForceResolveRequest, ForceResolveRequestBuilder> {
  /// Action to take - RETRY to retry, ABORT to cancel
  @BuiltValueField(wireName: r'action')
  ForceResolveRequestActionEnum get action;
  // enum actionEnum {  RETRY,  ABORT,  };

  /// Reason for force resolve
  @BuiltValueField(wireName: r'reason')
  String? get reason;

  /// ID of the admin performing the action
  @BuiltValueField(wireName: r'adminId')
  String get adminId;

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
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    yield r'adminId';
    yield serializers.serialize(
      object.adminId,
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
        case r'adminId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.adminId = valueDes;
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

  /// Action to take - RETRY to retry, ABORT to cancel
  @BuiltValueEnumConst(wireName: r'RETRY')
  static const ForceResolveRequestActionEnum RETRY = _$forceResolveRequestActionEnum_RETRY;
  /// Action to take - RETRY to retry, ABORT to cancel
  @BuiltValueEnumConst(wireName: r'ABORT')
  static const ForceResolveRequestActionEnum ABORT = _$forceResolveRequestActionEnum_ABORT;

  static Serializer<ForceResolveRequestActionEnum> get serializer => _$forceResolveRequestActionEnumSerializer;

  const ForceResolveRequestActionEnum._(String name): super(name);

  static BuiltSet<ForceResolveRequestActionEnum> get values => _$forceResolveRequestActionEnumValues;
  static ForceResolveRequestActionEnum valueOf(String name) => _$forceResolveRequestActionEnumValueOf(name);
}

