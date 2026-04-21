//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'checker_approve_action_legacy_request.g.dart';

/// CheckerApproveActionLegacyRequest
///
/// Properties:
/// * [caseId] 
/// * [userId] 
/// * [reason] 
@BuiltValue()
abstract class CheckerApproveActionLegacyRequest implements Built<CheckerApproveActionLegacyRequest, CheckerApproveActionLegacyRequestBuilder> {
  @BuiltValueField(wireName: r'caseId')
  String get caseId;

  @BuiltValueField(wireName: r'userId')
  String get userId;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  CheckerApproveActionLegacyRequest._();

  factory CheckerApproveActionLegacyRequest([void updates(CheckerApproveActionLegacyRequestBuilder b)]) = _$CheckerApproveActionLegacyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CheckerApproveActionLegacyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CheckerApproveActionLegacyRequest> get serializer => _$CheckerApproveActionLegacyRequestSerializer();
}

class _$CheckerApproveActionLegacyRequestSerializer implements PrimitiveSerializer<CheckerApproveActionLegacyRequest> {
  @override
  final Iterable<Type> types = const [CheckerApproveActionLegacyRequest, _$CheckerApproveActionLegacyRequest];

  @override
  final String wireName = r'CheckerApproveActionLegacyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CheckerApproveActionLegacyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'caseId';
    yield serializers.serialize(
      object.caseId,
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
    CheckerApproveActionLegacyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CheckerApproveActionLegacyRequestBuilder result,
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
  CheckerApproveActionLegacyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CheckerApproveActionLegacyRequestBuilder();
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

