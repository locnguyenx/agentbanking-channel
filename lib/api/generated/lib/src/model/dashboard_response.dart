//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/dashboard_response_daily_stats_inner.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_response.g.dart';

/// DashboardResponse
///
/// Properties:
/// * [totalAgents]
/// * [activeAgents]
/// * [totalTransactions]
/// * [totalVolume]
/// * [successRate]
/// * [dailyStats]
@BuiltValue()
abstract class DashboardResponse
    implements Built<DashboardResponse, DashboardResponseBuilder> {
  @BuiltValueField(wireName: r'totalAgents')
  int? get totalAgents;

  @BuiltValueField(wireName: r'activeAgents')
  int? get activeAgents;

  @BuiltValueField(wireName: r'totalTransactions')
  int? get totalTransactions;

  @BuiltValueField(wireName: r'totalVolume')
  num? get totalVolume;

  @BuiltValueField(wireName: r'successRate')
  num? get successRate;

  @BuiltValueField(wireName: r'dailyStats')
  BuiltList<DashboardResponseDailyStatsInner>? get dailyStats;

  DashboardResponse._();

  factory DashboardResponse([void updates(DashboardResponseBuilder b)]) =
      _$DashboardResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardResponse> get serializer =>
      _$DashboardResponseSerializer();
}

class _$DashboardResponseSerializer
    implements PrimitiveSerializer<DashboardResponse> {
  @override
  final Iterable<Type> types = const [DashboardResponse, _$DashboardResponse];

  @override
  final String wireName = r'DashboardResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalAgents != null) {
      yield r'totalAgents';
      yield serializers.serialize(
        object.totalAgents,
        specifiedType: const FullType(int),
      );
    }
    if (object.activeAgents != null) {
      yield r'activeAgents';
      yield serializers.serialize(
        object.activeAgents,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalTransactions != null) {
      yield r'totalTransactions';
      yield serializers.serialize(
        object.totalTransactions,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalVolume != null) {
      yield r'totalVolume';
      yield serializers.serialize(
        object.totalVolume,
        specifiedType: const FullType(num),
      );
    }
    if (object.successRate != null) {
      yield r'successRate';
      yield serializers.serialize(
        object.successRate,
        specifiedType: const FullType(num),
      );
    }
    if (object.dailyStats != null) {
      yield r'dailyStats';
      yield serializers.serialize(
        object.dailyStats,
        specifiedType: const FullType(
            BuiltList, [FullType(DashboardResponseDailyStatsInner)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalAgents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalAgents = valueDes;
          break;
        case r'activeAgents':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activeAgents = valueDes;
          break;
        case r'totalTransactions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalTransactions = valueDes;
          break;
        case r'totalVolume':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalVolume = valueDes;
          break;
        case r'successRate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.successRate = valueDes;
          break;
        case r'dailyStats':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltList, [FullType(DashboardResponseDailyStatsInner)]),
          ) as BuiltList<DashboardResponseDailyStatsInner>;
          result.dailyStats.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardResponseBuilder();
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
