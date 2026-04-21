//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:agent_api/src/model/agent_response.dart';
import 'package:agent_api/src/model/agent_stats.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_list_response.g.dart';

/// AgentListResponse
///
/// Properties:
/// * [agents] 
/// * [stats] 
/// * [page] 
/// * [size] 
@BuiltValue()
abstract class AgentListResponse implements Built<AgentListResponse, AgentListResponseBuilder> {
  @BuiltValueField(wireName: r'agents')
  BuiltList<AgentResponse>? get agents;

  @BuiltValueField(wireName: r'stats')
  AgentStats? get stats;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'size')
  int? get size;

  AgentListResponse._();

  factory AgentListResponse([void updates(AgentListResponseBuilder b)]) = _$AgentListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentListResponse> get serializer => _$AgentListResponseSerializer();
}

class _$AgentListResponseSerializer implements PrimitiveSerializer<AgentListResponse> {
  @override
  final Iterable<Type> types = const [AgentListResponse, _$AgentListResponse];

  @override
  final String wireName = r'AgentListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agents != null) {
      yield r'agents';
      yield serializers.serialize(
        object.agents,
        specifiedType: const FullType(BuiltList, [FullType(AgentResponse)]),
      );
    }
    if (object.stats != null) {
      yield r'stats';
      yield serializers.serialize(
        object.stats,
        specifiedType: const FullType(AgentStats),
      );
    }
    if (object.page != null) {
      yield r'page';
      yield serializers.serialize(
        object.page,
        specifiedType: const FullType(int),
      );
    }
    if (object.size != null) {
      yield r'size';
      yield serializers.serialize(
        object.size,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AgentListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentListResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AgentResponse)]),
          ) as BuiltList<AgentResponse>;
          result.agents.replace(valueDes);
          break;
        case r'stats':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AgentStats),
          ) as AgentStats;
          result.stats.replace(valueDes);
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgentListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentListResponseBuilder();
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

