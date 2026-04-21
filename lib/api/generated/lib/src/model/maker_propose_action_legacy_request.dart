//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'maker_propose_action_legacy_request.g.dart';

/// MakerProposeActionLegacyRequest
///
/// Properties:
/// * [caseId] 
/// * [action] 
/// * [userId] 
/// * [reason] 
@BuiltValue()
abstract class MakerProposeActionLegacyRequest implements Built<MakerProposeActionLegacyRequest, MakerProposeActionLegacyRequestBuilder> {
  @BuiltValueField(wireName: r'caseId')
  String get caseId;

  @BuiltValueField(wireName: r'action')
  String get action;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  MakerProposeActionLegacyRequest._();

  factory MakerProposeActionLegacyRequest([void updates(MakerProposeActionLegacyRequestBuilder b)]) = _$MakerProposeActionLegacyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MakerProposeActionLegacyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MakerProposeActionLegacyRequest> get serializer => _$MakerProposeActionLegacyRequestSerializer();
}

class _$MakerProposeActionLegacyRequestSerializer implements PrimitiveSerializer<MakerProposeActionLegacyRequest> {
  @override
  final Iterable<Type> types = const [MakerProposeActionLegacyRequest, _$MakerProposeActionLegacyRequest];

  @override
  final String wireName = r'MakerProposeActionLegacyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MakerProposeActionLegacyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'caseId';
    yield serializers.serialize(
      object.caseId,
      specifiedType: const FullType(String),
    );
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(String),
    );
    yield r'userId';
    yield serializers.serialize(
      object.userId,
      specifiedType: const FullType(String),
    );
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MakerProposeActionLegacyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MakerProposeActionLegacyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'caseId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.caseId = valueDes;
          break;
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.action = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
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
  MakerProposeActionLegacyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MakerProposeActionLegacyRequestBuilder();
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

