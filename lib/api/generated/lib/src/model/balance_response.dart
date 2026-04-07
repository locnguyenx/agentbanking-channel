//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'balance_response.g.dart';

/// BalanceResponse
///
/// Properties:
/// * [agentId] 
/// * [availableBalance] 
/// * [ledgerBalance] 
/// * [pendingBalance] 
/// * [currency] 
/// * [lastTransactionId] 
/// * [lastUpdated] 
@BuiltValue()
abstract class BalanceResponse implements Built<BalanceResponse, BalanceResponseBuilder> {
  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'availableBalance')
  String? get availableBalance;

  @BuiltValueField(wireName: r'ledgerBalance')
  String? get ledgerBalance;

  @BuiltValueField(wireName: r'pendingBalance')
  String? get pendingBalance;

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'lastTransactionId')
  String? get lastTransactionId;

  @BuiltValueField(wireName: r'lastUpdated')
  DateTime? get lastUpdated;

  BalanceResponse._();

  factory BalanceResponse([void updates(BalanceResponseBuilder b)]) = _$BalanceResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BalanceResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BalanceResponse> get serializer => _$BalanceResponseSerializer();
}

class _$BalanceResponseSerializer implements PrimitiveSerializer<BalanceResponse> {
  @override
  final Iterable<Type> types = const [BalanceResponse, _$BalanceResponse];

  @override
  final String wireName = r'BalanceResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BalanceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.availableBalance != null) {
      yield r'availableBalance';
      yield serializers.serialize(
        object.availableBalance,
        specifiedType: const FullType(String),
      );
    }
    if (object.ledgerBalance != null) {
      yield r'ledgerBalance';
      yield serializers.serialize(
        object.ledgerBalance,
        specifiedType: const FullType(String),
      );
    }
    if (object.pendingBalance != null) {
      yield r'pendingBalance';
      yield serializers.serialize(
        object.pendingBalance,
        specifiedType: const FullType(String),
      );
    }
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastTransactionId != null) {
      yield r'lastTransactionId';
      yield serializers.serialize(
        object.lastTransactionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.lastUpdated != null) {
      yield r'lastUpdated';
      yield serializers.serialize(
        object.lastUpdated,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BalanceResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BalanceResponseBuilder result,
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
        case r'availableBalance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableBalance = valueDes;
          break;
        case r'ledgerBalance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ledgerBalance = valueDes;
          break;
        case r'pendingBalance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pendingBalance = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'lastTransactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastTransactionId = valueDes;
          break;
        case r'lastUpdated':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastUpdated = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BalanceResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BalanceResponseBuilder();
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

