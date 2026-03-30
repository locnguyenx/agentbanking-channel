//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'deposit_request.g.dart';

/// DepositRequest
///
/// Properties:
/// * [agentId] 
/// * [amount] 
/// * [customerFee] 
/// * [agentCommission] 
/// * [bankShare] 
/// * [idempotencyKey] 
/// * [destinationAccount] 
@BuiltValue()
abstract class DepositRequest implements Built<DepositRequest, DepositRequestBuilder> {
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

  @BuiltValueField(wireName: r'destinationAccount')
  String? get destinationAccount;

  DepositRequest._();

  factory DepositRequest([void updates(DepositRequestBuilder b)]) = _$DepositRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositRequest> get serializer => _$DepositRequestSerializer();
}

class _$DepositRequestSerializer implements PrimitiveSerializer<DepositRequest> {
  @override
  final Iterable<Type> types = const [DepositRequest, _$DepositRequest];

  @override
  final String wireName = r'DepositRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositRequest object, {
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
    if (object.destinationAccount != null) {
      yield r'destinationAccount';
      yield serializers.serialize(
        object.destinationAccount,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DepositRequestBuilder result,
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
        case r'destinationAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAccount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DepositRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositRequestBuilder();
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

