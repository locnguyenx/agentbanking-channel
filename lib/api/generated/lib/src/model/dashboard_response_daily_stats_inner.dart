//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_response_daily_stats_inner.g.dart';

/// DashboardResponseDailyStatsInner
///
/// Properties:
/// * [date]
/// * [transactionCount]
/// * [volume]
@BuiltValue()
abstract class DashboardResponseDailyStatsInner
    implements
        Built<DashboardResponseDailyStatsInner,
            DashboardResponseDailyStatsInnerBuilder> {
  @BuiltValueField(wireName: r'date')
  String? get date;

  @BuiltValueField(wireName: r'transactionCount')
  int? get transactionCount;

  @BuiltValueField(wireName: r'volume')
  num? get volume;

  DashboardResponseDailyStatsInner._();

  factory DashboardResponseDailyStatsInner(
          [void updates(DashboardResponseDailyStatsInnerBuilder b)]) =
      _$DashboardResponseDailyStatsInner;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardResponseDailyStatsInnerBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardResponseDailyStatsInner> get serializer =>
      _$DashboardResponseDailyStatsInnerSerializer();
}

class _$DashboardResponseDailyStatsInnerSerializer
    implements PrimitiveSerializer<DashboardResponseDailyStatsInner> {
  @override
  final Iterable<Type> types = const [
    DashboardResponseDailyStatsInner,
    _$DashboardResponseDailyStatsInner
  ];

  @override
  final String wireName = r'DashboardResponseDailyStatsInner';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardResponseDailyStatsInner object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionCount != null) {
      yield r'transactionCount';
      yield serializers.serialize(
        object.transactionCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.volume != null) {
      yield r'volume';
      yield serializers.serialize(
        object.volume,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardResponseDailyStatsInner object, {
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
    required DashboardResponseDailyStatsInnerBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.date = valueDes;
          break;
        case r'transactionCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.transactionCount = valueDes;
          break;
        case r'volume':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.volume = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardResponseDailyStatsInner deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardResponseDailyStatsInnerBuilder();
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
