// @dart=2.19
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'withdrawal_request.g.dart';

/// WithdrawalRequest
///
/// Properties:
/// * [agentId] 
/// * [amount] 
/// * [customerFee] 
/// * [agentCommission] 
/// * [bankShare] 
/// * [idempotencyKey] 
/// * [customerCardMasked] 
/// * [geofenceLat] 
/// * [geofenceLng] 
@BuiltValue()
abstract class WithdrawalRequest implements Built<WithdrawalRequest, WithdrawalRequestBuilder> {
  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'customerFee')
  num? get customerFee;

  @BuiltValueField(wireName: r'agentCommission')
  num? get agentCommission;

  @BuiltValueField(wireName: r'bankShare')
  num? get bankShare;

  @BuiltValueField(wireName: r'idempotencyKey')
  String? get idempotencyKey;

  @BuiltValueField(wireName: r'customerCardMasked')
  String? get customerCardMasked;

  @BuiltValueField(wireName: r'geofenceLat')
  num? get geofenceLat;

  @BuiltValueField(wireName: r'geofenceLng')
  num? get geofenceLng;

  WithdrawalRequest._();

  factory WithdrawalRequest([void updates(WithdrawalRequestBuilder b)]) = _$WithdrawalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(WithdrawalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<WithdrawalRequest> get serializer => _$WithdrawalRequestSerializer();
}

class _$WithdrawalRequestSerializer implements PrimitiveSerializer<WithdrawalRequest> {
  @override
  final Iterable<Type> types = const [WithdrawalRequest, _$WithdrawalRequest];

  @override
  final String wireName = r'WithdrawalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    WithdrawalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(num),
      );
    }
    if (object.customerFee != null) {
      yield r'customerFee';
      yield serializers.serialize(
        object.customerFee,
        specifiedType: const FullType(num),
      );
    }
    if (object.agentCommission != null) {
      yield r'agentCommission';
      yield serializers.serialize(
        object.agentCommission,
        specifiedType: const FullType(num),
      );
    }
    if (object.bankShare != null) {
      yield r'bankShare';
      yield serializers.serialize(
        object.bankShare,
        specifiedType: const FullType(num),
      );
    }
    if (object.idempotencyKey != null) {
      yield r'idempotencyKey';
      yield serializers.serialize(
        object.idempotencyKey,
        specifiedType: const FullType(String),
      );
    }
    if (object.customerCardMasked != null) {
      yield r'customerCardMasked';
      yield serializers.serialize(
        object.customerCardMasked,
        specifiedType: const FullType(String),
      );
    }
    if (object.geofenceLat != null) {
      yield r'geofenceLat';
      yield serializers.serialize(
        object.geofenceLat,
        specifiedType: const FullType(num),
      );
    }
    if (object.geofenceLng != null) {
      yield r'geofenceLng';
      yield serializers.serialize(
        object.geofenceLng,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    WithdrawalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required WithdrawalRequestBuilder result,
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
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'customerFee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.customerFee = valueDes;
          break;
        case r'agentCommission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.agentCommission = valueDes;
          break;
        case r'bankShare':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.bankShare = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerCardMasked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerCardMasked = valueDes;
          break;
        case r'geofenceLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.geofenceLat = valueDes;
          break;
        case r'geofenceLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.geofenceLng = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  WithdrawalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = WithdrawalRequestBuilder();
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

