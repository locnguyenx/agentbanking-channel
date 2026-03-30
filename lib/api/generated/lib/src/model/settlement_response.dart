//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'settlement_response.g.dart';

/// SettlementResponse
///
/// Properties:
/// * [settlementId] 
/// * [agentId] 
/// * [date] 
/// * [totalTransactions] 
/// * [totalAmount] 
/// * [commission] 
/// * [status] 
@BuiltValue()
abstract class SettlementResponse implements Built<SettlementResponse, SettlementResponseBuilder> {
  @BuiltValueField(wireName: r'settlementId')
  String? get settlementId;

  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'date')
  Date? get date;

  @BuiltValueField(wireName: r'totalTransactions')
  int? get totalTransactions;

  @BuiltValueField(wireName: r'totalAmount')
  num? get totalAmount;

  @BuiltValueField(wireName: r'commission')
  num? get commission;

  @BuiltValueField(wireName: r'status')
  String? get status;

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
    if (object.settlementId != null) {
      yield r'settlementId';
      yield serializers.serialize(
        object.settlementId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.date != null) {
      yield r'date';
      yield serializers.serialize(
        object.date,
        specifiedType: const FullType(Date),
      );
    }
    if (object.totalTransactions != null) {
      yield r'totalTransactions';
      yield serializers.serialize(
        object.totalTransactions,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalAmount != null) {
      yield r'totalAmount';
      yield serializers.serialize(
        object.totalAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.commission != null) {
      yield r'commission';
      yield serializers.serialize(
        object.commission,
        specifiedType: const FullType(num),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
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
        case r'settlementId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.settlementId = valueDes;
          break;
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentId = valueDes;
          break;
        case r'date':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.date = valueDes;
          break;
        case r'totalTransactions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalTransactions = valueDes;
          break;
        case r'totalAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalAmount = valueDes;
          break;
        case r'commission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.commission = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
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

