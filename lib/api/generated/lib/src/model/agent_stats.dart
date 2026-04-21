//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_stats.g.dart';

/// AgentStats
///
/// Properties:
/// * [total] 
/// * [active] 
/// * [suspended] 
/// * [inactive] 
@BuiltValue()
abstract class AgentStats implements Built<AgentStats, AgentStatsBuilder> {
  @BuiltValueField(wireName: r'total')
  int? get total;

  @BuiltValueField(wireName: r'active')
  int? get active;

  @BuiltValueField(wireName: r'suspended')
  int? get suspended;

  @BuiltValueField(wireName: r'inactive')
  int? get inactive;

  AgentStats._();

  factory AgentStats([void updates(AgentStatsBuilder b)]) = _$AgentStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentStats> get serializer => _$AgentStatsSerializer();
}

class _$AgentStatsSerializer implements PrimitiveSerializer<AgentStats> {
  @override
  final Iterable<Type> types = const [AgentStats, _$AgentStats];

  @override
  final String wireName = r'AgentStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
    if (object.active != null) {
      yield r'active';
      yield serializers.serialize(
        object.active,
        specifiedType: const FullType(int),
      );
    }
    if (object.suspended != null) {
      yield r'suspended';
      yield serializers.serialize(
        object.suspended,
        specifiedType: const FullType(int),
      );
    }
    if (object.inactive != null) {
      yield r'inactive';
      yield serializers.serialize(
        object.inactive,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    AgentStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentStatsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'active':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.active = valueDes;
          break;
        case r'suspended':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.suspended = valueDes;
          break;
        case r'inactive':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.inactive = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AgentStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentStatsBuilder();
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

