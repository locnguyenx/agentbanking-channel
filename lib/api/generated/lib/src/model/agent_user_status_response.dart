//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_user_status_response.g.dart';

/// AgentUserStatusResponse
///
/// Properties:
/// * [agentId] 
/// * [status] 
/// * [userId] 
/// * [error] 
@BuiltValue()
abstract class AgentUserStatusResponse implements Built<AgentUserStatusResponse, AgentUserStatusResponseBuilder> {
  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'status')
  AgentUserStatusResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  CREATED,  FAILED,  };

  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'error')
  String? get error;

  AgentUserStatusResponse._();

  factory AgentUserStatusResponse([void updates(AgentUserStatusResponseBuilder b)]) = _$AgentUserStatusResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentUserStatusResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentUserStatusResponse> get serializer => _$AgentUserStatusResponseSerializer();
}

class _$AgentUserStatusResponseSerializer implements PrimitiveSerializer<AgentUserStatusResponse> {
  @override
  final Iterable<Type> types = const [AgentUserStatusResponse, _$AgentUserStatusResponse];

  @override
  final String wireName = r'AgentUserStatusResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentUserStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AgentUserStatusResponseStatusEnum),
      );
    }
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType(String),
      );
    }
    if (object.error != null) {
      yield r'error';
      yield serializers.serialize(
        object.error,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AgentUserStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentUserStatusResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AgentUserStatusResponseStatusEnum),
          ) as AgentUserStatusResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.userId = valueDes;
          break;
        case r'error':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.error = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgentUserStatusResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentUserStatusResponseBuilder();
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

class AgentUserStatusResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AgentUserStatusResponseStatusEnum PENDING = _$agentUserStatusResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'CREATED')
  static const AgentUserStatusResponseStatusEnum CREATED = _$agentUserStatusResponseStatusEnum_CREATED;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const AgentUserStatusResponseStatusEnum FAILED = _$agentUserStatusResponseStatusEnum_FAILED;

  static Serializer<AgentUserStatusResponseStatusEnum> get serializer => _$agentUserStatusResponseStatusEnumSerializer;

  const AgentUserStatusResponseStatusEnum._(String name): super(name);

  static BuiltSet<AgentUserStatusResponseStatusEnum> get values => _$agentUserStatusResponseStatusEnumValues;
  static AgentUserStatusResponseStatusEnum valueOf(String name) => _$agentUserStatusResponseStatusEnumValueOf(name);
}

