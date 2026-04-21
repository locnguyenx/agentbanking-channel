//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:agent_api/src/model/transaction_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_start_request.g.dart';

/// TransactionStartRequest
///
/// Properties:
/// * [transactionType] 
/// * [agentId] - Unique identifier of the agent
/// * [amount] - Transaction amount in MYR
/// * [idempotencyKey] - Optional unique key to prevent duplicate transactions. If not provided, server will generate one.
/// * [pan] - Card number (PAN) - required for CASH_WITHDRAWAL
/// * [pinBlock] - Encrypted PIN block - required for CASH_WITHDRAWAL
/// * [customerCardMasked] - Masked card number for display (e.g., 411111******1111)
/// * [destinationAccount] - Destination account number - required for CASH_DEPOSIT
/// * [requiresBiometric] - Whether biometric verification is required
/// * [billerCode] - Biller code - required for BILL_PAYMENT
/// * [ref1] - Reference 1 (bill account number) - required for BILL_PAYMENT
/// * [ref2] - Reference 2 (optional) - for BILL_PAYMENT
/// * [proxyType] - DuitNow proxy type - required for DUITNOW_TRANSFER
/// * [proxyValue] - DuitNow proxy value - required for DUITNOW_TRANSFER
/// * [customerMykad] - Encrypted customer MyKad number
/// * [geofenceLat] - GPS latitude of transaction location
/// * [geofenceLng] - GPS longitude of transaction location
/// * [targetBIN] - Target bank BIN for routing
/// * [agentTier] - Agent tier level
@BuiltValue()
abstract class TransactionStartRequest implements Built<TransactionStartRequest, TransactionStartRequestBuilder> {
  @BuiltValueField(wireName: r'transactionType')
  TransactionType get transactionType;
  // enum transactionTypeEnum {  CASH_WITHDRAWAL,  CASH_DEPOSIT,  BILL_PAYMENT,  DUITNOW_TRANSFER,  CASHLESS_PAYMENT,  PIN_BASED_PURCHASE,  PREPAID_TOPUP,  EWALLET_WITHDRAWAL,  EWALLET_TOPUP,  ESSP_PURCHASE,  PIN_PURCHASE,  RETAIL_SALE,  HYBRID_CASHBACK,  };

  /// Unique identifier of the agent
  @BuiltValueField(wireName: r'agentId')
  String get agentId;

  /// Transaction amount in MYR
  @BuiltValueField(wireName: r'amount')
  double get amount;

  /// Optional unique key to prevent duplicate transactions. If not provided, server will generate one.
  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  /// Card number (PAN) - required for CASH_WITHDRAWAL
  @BuiltValueField(wireName: r'pan')
  String? get pan;

  /// Encrypted PIN block - required for CASH_WITHDRAWAL
  @BuiltValueField(wireName: r'pinBlock')
  String? get pinBlock;

  /// Masked card number for display (e.g., 411111******1111)
  @BuiltValueField(wireName: r'customerCardMasked')
  String? get customerCardMasked;

  /// Destination account number - required for CASH_DEPOSIT
  @BuiltValueField(wireName: r'destinationAccount')
  String? get destinationAccount;

  /// Whether biometric verification is required
  @BuiltValueField(wireName: r'requiresBiometric')
  bool? get requiresBiometric;

  /// Biller code - required for BILL_PAYMENT
  @BuiltValueField(wireName: r'billerCode')
  String? get billerCode;

  /// Reference 1 (bill account number) - required for BILL_PAYMENT
  @BuiltValueField(wireName: r'ref1')
  String? get ref1;

  /// Reference 2 (optional) - for BILL_PAYMENT
  @BuiltValueField(wireName: r'ref2')
  String? get ref2;

  /// DuitNow proxy type - required for DUITNOW_TRANSFER
  @BuiltValueField(wireName: r'proxyType')
  TransactionStartRequestProxyTypeEnum? get proxyType;
  // enum proxyTypeEnum {  IC,  PHONE,  EMAIL,  TGAN,  };

  /// DuitNow proxy value - required for DUITNOW_TRANSFER
  @BuiltValueField(wireName: r'proxyValue')
  String? get proxyValue;

  /// Encrypted customer MyKad number
  @BuiltValueField(wireName: r'customerMykad')
  String? get customerMykad;

  /// GPS latitude of transaction location
  @BuiltValueField(wireName: r'geofenceLat')
  double? get geofenceLat;

  /// GPS longitude of transaction location
  @BuiltValueField(wireName: r'geofenceLng')
  double? get geofenceLng;

  /// Target bank BIN for routing
  @BuiltValueField(wireName: r'targetBIN')
  String? get targetBIN;

  /// Agent tier level
  @BuiltValueField(wireName: r'agentTier')
  TransactionStartRequestAgentTierEnum? get agentTier;
  // enum agentTierEnum {  MICRO,  STANDARD,  PREMIER,  };

  TransactionStartRequest._();

  factory TransactionStartRequest([void updates(TransactionStartRequestBuilder b)]) = _$TransactionStartRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionStartRequestBuilder b) => b
      ..requiresBiometric = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionStartRequest> get serializer => _$TransactionStartRequestSerializer();
}

class _$TransactionStartRequestSerializer implements PrimitiveSerializer<TransactionStartRequest> {
  @override
  final Iterable<Type> types = const [TransactionStartRequest, _$TransactionStartRequest];

  @override
  final String wireName = r'TransactionStartRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionStartRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'transactionType';
    yield serializers.serialize(
      object.transactionType,
      specifiedType: const FullType(TransactionType),
    );
    yield r'agentId';
    yield serializers.serialize(
      object.agentId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(double),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    if (object.pan != null) {
      yield r'pan';
      yield serializers.serialize(
        object.pan,
        specifiedType: const FullType(String),
      );
    }
    if (object.pinBlock != null) {
      yield r'pinBlock';
      yield serializers.serialize(
        object.pinBlock,
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
    if (object.destinationAccount != null) {
      yield r'destinationAccount';
      yield serializers.serialize(
        object.destinationAccount,
        specifiedType: const FullType(String),
      );
    }
    if (object.requiresBiometric != null) {
      yield r'requiresBiometric';
      yield serializers.serialize(
        object.requiresBiometric,
        specifiedType: const FullType(bool),
      );
    }
    if (object.billerCode != null) {
      yield r'billerCode';
      yield serializers.serialize(
        object.billerCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.ref1 != null) {
      yield r'ref1';
      yield serializers.serialize(
        object.ref1,
        specifiedType: const FullType(String),
      );
    }
    if (object.ref2 != null) {
      yield r'ref2';
      yield serializers.serialize(
        object.ref2,
        specifiedType: const FullType(String),
      );
    }
    if (object.proxyType != null) {
      yield r'proxyType';
      yield serializers.serialize(
        object.proxyType,
        specifiedType: const FullType(TransactionStartRequestProxyTypeEnum),
      );
    }
    if (object.proxyValue != null) {
      yield r'proxyValue';
      yield serializers.serialize(
        object.proxyValue,
        specifiedType: const FullType(String),
      );
    }
    if (object.customerMykad != null) {
      yield r'customerMykad';
      yield serializers.serialize(
        object.customerMykad,
        specifiedType: const FullType(String),
      );
    }
    if (object.geofenceLat != null) {
      yield r'geofenceLat';
      yield serializers.serialize(
        object.geofenceLat,
        specifiedType: const FullType(double),
      );
    }
    if (object.geofenceLng != null) {
      yield r'geofenceLng';
      yield serializers.serialize(
        object.geofenceLng,
        specifiedType: const FullType(double),
      );
    }
    if (object.targetBIN != null) {
      yield r'targetBIN';
      yield serializers.serialize(
        object.targetBIN,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentTier != null) {
      yield r'agentTier';
      yield serializers.serialize(
        object.agentTier,
        specifiedType: const FullType(TransactionStartRequestAgentTierEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionStartRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionStartRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transactionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionType),
          ) as TransactionType;
          result.transactionType = valueDes;
          break;
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
            specifiedType: const FullType(double),
          ) as double;
          result.amount = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'pan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pan = valueDes;
          break;
        case r'pinBlock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pinBlock = valueDes;
          break;
        case r'customerCardMasked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerCardMasked = valueDes;
          break;
        case r'destinationAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.destinationAccount = valueDes;
          break;
        case r'requiresBiometric':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresBiometric = valueDes;
          break;
        case r'billerCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.billerCode = valueDes;
          break;
        case r'ref1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref1 = valueDes;
          break;
        case r'ref2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref2 = valueDes;
          break;
        case r'proxyType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionStartRequestProxyTypeEnum),
          ) as TransactionStartRequestProxyTypeEnum;
          result.proxyType = valueDes;
          break;
        case r'proxyValue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.proxyValue = valueDes;
          break;
        case r'customerMykad':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerMykad = valueDes;
          break;
        case r'geofenceLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.geofenceLat = valueDes;
          break;
        case r'geofenceLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.geofenceLng = valueDes;
          break;
        case r'targetBIN':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.targetBIN = valueDes;
          break;
        case r'agentTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionStartRequestAgentTierEnum),
          ) as TransactionStartRequestAgentTierEnum;
          result.agentTier = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionStartRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionStartRequestBuilder();
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

class TransactionStartRequestProxyTypeEnum extends EnumClass {

  /// DuitNow proxy type - required for DUITNOW_TRANSFER
  @BuiltValueEnumConst(wireName: r'IC')
  static const TransactionStartRequestProxyTypeEnum IC = _$transactionStartRequestProxyTypeEnum_IC;
  /// DuitNow proxy type - required for DUITNOW_TRANSFER
  @BuiltValueEnumConst(wireName: r'PHONE')
  static const TransactionStartRequestProxyTypeEnum PHONE = _$transactionStartRequestProxyTypeEnum_PHONE;
  /// DuitNow proxy type - required for DUITNOW_TRANSFER
  @BuiltValueEnumConst(wireName: r'EMAIL')
  static const TransactionStartRequestProxyTypeEnum EMAIL = _$transactionStartRequestProxyTypeEnum_EMAIL;
  /// DuitNow proxy type - required for DUITNOW_TRANSFER
  @BuiltValueEnumConst(wireName: r'TGAN')
  static const TransactionStartRequestProxyTypeEnum TGAN = _$transactionStartRequestProxyTypeEnum_TGAN;

  static Serializer<TransactionStartRequestProxyTypeEnum> get serializer => _$transactionStartRequestProxyTypeEnumSerializer;

  const TransactionStartRequestProxyTypeEnum._(String name): super(name);

  static BuiltSet<TransactionStartRequestProxyTypeEnum> get values => _$transactionStartRequestProxyTypeEnumValues;
  static TransactionStartRequestProxyTypeEnum valueOf(String name) => _$transactionStartRequestProxyTypeEnumValueOf(name);
}

class TransactionStartRequestAgentTierEnum extends EnumClass {

  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'MICRO')
  static const TransactionStartRequestAgentTierEnum MICRO = _$transactionStartRequestAgentTierEnum_MICRO;
  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const TransactionStartRequestAgentTierEnum STANDARD = _$transactionStartRequestAgentTierEnum_STANDARD;
  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const TransactionStartRequestAgentTierEnum PREMIER = _$transactionStartRequestAgentTierEnum_PREMIER;

  static Serializer<TransactionStartRequestAgentTierEnum> get serializer => _$transactionStartRequestAgentTierEnumSerializer;

  const TransactionStartRequestAgentTierEnum._(String name): super(name);

  static BuiltSet<TransactionStartRequestAgentTierEnum> get values => _$transactionStartRequestAgentTierEnumValues;
  static TransactionStartRequestAgentTierEnum valueOf(String name) => _$transactionStartRequestAgentTierEnumValueOf(name);
}

