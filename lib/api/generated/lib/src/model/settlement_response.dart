//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/date.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'settlement_response.g.dart';

/// SettlementResponse
///
/// Properties:
/// * [transactions] 
/// * [totalDebits] 
/// * [totalCredits] 
/// * [totalCommissions] 
/// * [netAmount] 
/// * [date] 
@BuiltValue()
abstract class SettlementResponse implements Built<SettlementResponse, SettlementResponseBuilder> {
  @BuiltValueField(wireName: r'transactions')
  BuiltList<BuiltMap<String, JsonObject?>>? get transactions;

  @BuiltValueField(wireName: r'totalDebits')
  num? get totalDebits;

  @BuiltValueField(wireName: r'totalCredits')
  num? get totalCredits;

  @BuiltValueField(wireName: r'totalCommissions')
  num? get totalCommissions;

  @BuiltValueField(wireName: r'netAmount')
  num? get netAmount;

  @BuiltValueField(wireName: r'date')
  Date? get date;

  SettlementResponse._();

  factory SettlementResponse([void updates(SettlementResponseBuilder b)]) = _$SettlementResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SettlementResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SettlementResponse> get serializer => _$SettlementResponseSerializer();
}

class _$SettlementResponseSerializer implements PrimitiveSerializer<SettlementResponse> {
  @override
  final Iterable<Type> types = const [SettlementResponse, _$SettlementResponse];

  @override
  final String wireName = r'SettlementResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SettlementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.transactions != null) {
      yield r'transactions';
      yield serializers.serialize(
        object.transactions,
        specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
      );
    }
    if (object.totalDebits != null) {
      yield r'totalDebits';
      yield serializers.serialize(
        object.totalDebits,
        specifiedType: const FullType(num),
      );
    }
    if (object.totalCredits != null) {
      yield r'totalCredits';
      yield serializers.serialize(
        object.totalCredits,
        specifiedType: const FullType(num),
      );
    }
    if (object.totalCommissions != null) {
      yield r'totalCommissions';
      yield serializers.serialize(
        object.totalCommissions,
        specifiedType: const FullType(num),
      );
    }
    if (object.netAmount != null) {
      yield r'netAmount';
      yield serializers.serialize(
        object.netAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SettlementResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SettlementResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transactions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
          ) as BuiltList<BuiltMap<String, JsonObject?>>;
          result.transactions.replace(valueDes);
          break;
        case r'totalDebits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalDebits = valueDes;
          break;
        case r'totalCredits':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalCredits = valueDes;
          break;
        case r'totalCommissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalCommissions = valueDes;
          break;
        case r'netAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.netAmount = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SettlementResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SettlementResponseBuilder();
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

