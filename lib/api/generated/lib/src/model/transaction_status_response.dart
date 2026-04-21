//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_status_response.g.dart';

/// TransactionStatusResponse
///
/// Properties:
/// * [status] - Current workflow status
/// * [workflowId] - Workflow identifier
/// * [transactionType] - Type of transaction
/// * [amount] - Transaction amount
/// * [customerFee] - Fee charged to customer
/// * [referenceNumber] - External reference number from switch/biller
/// * [errorCode] - Error code if transaction failed
/// * [errorMessage] - Human-readable error message
/// * [actionCode] - Recommended action for failed transactions
/// * [completedAt] - Timestamp when transaction completed
/// * [agentTier] 
/// * [billerCode] 
/// * [customerCardMasked] 
/// * [destinationAccount] 
/// * [errorDetails] 
/// * [geofenceLat] 
/// * [geofenceLng] 
/// * [pendingReason] 
/// * [ref1] 
/// * [ref2] 
/// * [targetBin] 
@BuiltValue()
abstract class TransactionStatusResponse implements Built<TransactionStatusResponse, TransactionStatusResponseBuilder> {
  /// Current workflow status
  @BuiltValueField(wireName: r'status')
  TransactionStatusResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  RUNNING,  COMPLETED,  FAILED,  COMPENSATING,  UNKNOWN,  };

  /// Workflow identifier
  @BuiltValueField(wireName: r'workflowId')
  String? get workflowId;

  /// Type of transaction
  @BuiltValueField(wireName: r'transactionType')
  String? get transactionType;

  /// Transaction amount
  @BuiltValueField(wireName: r'amount')
  double? get amount;

  /// Fee charged to customer
  @BuiltValueField(wireName: r'customerFee')
  double? get customerFee;

  /// External reference number from switch/biller
  @BuiltValueField(wireName: r'referenceNumber')
  String? get referenceNumber;

  /// Error code if transaction failed
  @BuiltValueField(wireName: r'errorCode')
  String? get errorCode;

  /// Human-readable error message
  @BuiltValueField(wireName: r'errorMessage')
  String? get errorMessage;

  /// Recommended action for failed transactions
  @BuiltValueField(wireName: r'actionCode')
  TransactionStatusResponseActionCodeEnum? get actionCode;
  // enum actionCodeEnum {  DECLINE,  RETRY,  REVIEW,  };

  /// Timestamp when transaction completed
  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  @BuiltValueField(wireName: r'agentTier')
  String? get agentTier;

  @BuiltValueField(wireName: r'billerCode')
  String? get billerCode;

  @BuiltValueField(wireName: r'customerCardMasked')
  String? get customerCardMasked;

  @BuiltValueField(wireName: r'destinationAccount')
  String? get destinationAccount;

  @BuiltValueField(wireName: r'errorDetails')
  JsonObject? get errorDetails;

  @BuiltValueField(wireName: r'geofenceLat')
  double? get geofenceLat;

  @BuiltValueField(wireName: r'geofenceLng')
  double? get geofenceLng;

  @BuiltValueField(wireName: r'pendingReason')
  String? get pendingReason;

  @BuiltValueField(wireName: r'ref1')
  String? get ref1;

  @BuiltValueField(wireName: r'ref2')
  String? get ref2;

  @BuiltValueField(wireName: r'targetBin')
  String? get targetBin;

  TransactionStatusResponse._();

  factory TransactionStatusResponse([void updates(TransactionStatusResponseBuilder b)]) = _$TransactionStatusResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionStatusResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionStatusResponse> get serializer => _$TransactionStatusResponseSerializer();
}

class _$TransactionStatusResponseSerializer implements PrimitiveSerializer<TransactionStatusResponse> {
  @override
  final Iterable<Type> types = const [TransactionStatusResponse, _$TransactionStatusResponse];

  @override
  final String wireName = r'TransactionStatusResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TransactionStatusResponseStatusEnum),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionType != null) {
      yield r'transactionType';
      yield serializers.serialize(
        object.transactionType,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(double),
      );
    }
    if (object.customerFee != null) {
      yield r'customerFee';
      yield serializers.serialize(
        object.customerFee,
        specifiedType: const FullType(double),
      );
    }
    if (object.referenceNumber != null) {
      yield r'referenceNumber';
      yield serializers.serialize(
        object.referenceNumber,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.errorCode != null) {
      yield r'errorCode';
      yield serializers.serialize(
        object.errorCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.errorMessage != null) {
      yield r'errorMessage';
      yield serializers.serialize(
        object.errorMessage,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.actionCode != null) {
      yield r'actionCode';
      yield serializers.serialize(
        object.actionCode,
        specifiedType: const FullType.nullable(TransactionStatusResponseActionCodeEnum),
      );
    }
    if (object.completedAt != null) {
      yield r'completedAt';
      yield serializers.serialize(
        object.completedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.agentTier != null) {
      yield r'agentTier';
      yield serializers.serialize(
        object.agentTier,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.billerCode != null) {
      yield r'billerCode';
      yield serializers.serialize(
        object.billerCode,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.customerCardMasked != null) {
      yield r'customerCardMasked';
      yield serializers.serialize(
        object.customerCardMasked,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.destinationAccount != null) {
      yield r'destinationAccount';
      yield serializers.serialize(
        object.destinationAccount,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.errorDetails != null) {
      yield r'errorDetails';
      yield serializers.serialize(
        object.errorDetails,
        specifiedType: const FullType.nullable(JsonObject),
      );
    }
    if (object.geofenceLat != null) {
      yield r'geofenceLat';
      yield serializers.serialize(
        object.geofenceLat,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.geofenceLng != null) {
      yield r'geofenceLng';
      yield serializers.serialize(
        object.geofenceLng,
        specifiedType: const FullType.nullable(double),
      );
    }
    if (object.pendingReason != null) {
      yield r'pendingReason';
      yield serializers.serialize(
        object.pendingReason,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ref1 != null) {
      yield r'ref1';
      yield serializers.serialize(
        object.ref1,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.ref2 != null) {
      yield r'ref2';
      yield serializers.serialize(
        object.ref2,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.targetBin != null) {
      yield r'targetBin';
      yield serializers.serialize(
        object.targetBin,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionStatusResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionStatusResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionStatusResponseStatusEnum),
          ) as TransactionStatusResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workflowId = valueDes;
          break;
        case r'transactionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.transactionType = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.amount = valueDes;
          break;
        case r'customerFee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.customerFee = valueDes;
          break;
        case r'referenceNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referenceNumber = valueDes;
          break;
        case r'errorCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.errorCode = valueDes;
          break;
        case r'errorMessage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.errorMessage = valueDes;
          break;
        case r'actionCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TransactionStatusResponseActionCodeEnum),
          ) as TransactionStatusResponseActionCodeEnum?;
          if (valueDes == null) continue;
          result.actionCode = valueDes;
          break;
        case r'completedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        case r'agentTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentTier = valueDes;
          break;
        case r'billerCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.billerCode = valueDes;
          break;
        case r'customerCardMasked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.customerCardMasked = valueDes;
          break;
        case r'destinationAccount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.destinationAccount = valueDes;
          break;
        case r'errorDetails':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.errorDetails = valueDes;
          break;
        case r'geofenceLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.geofenceLat = valueDes;
          break;
        case r'geofenceLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(double),
          ) as double?;
          if (valueDes == null) continue;
          result.geofenceLng = valueDes;
          break;
        case r'pendingReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pendingReason = valueDes;
          break;
        case r'ref1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ref1 = valueDes;
          break;
        case r'ref2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.ref2 = valueDes;
          break;
        case r'targetBin':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.targetBin = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionStatusResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionStatusResponseBuilder();
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

class TransactionStatusResponseStatusEnum extends EnumClass {

  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const TransactionStatusResponseStatusEnum PENDING = _$transactionStatusResponseStatusEnum_PENDING;
  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'RUNNING')
  static const TransactionStatusResponseStatusEnum RUNNING = _$transactionStatusResponseStatusEnum_RUNNING;
  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'COMPLETED')
  static const TransactionStatusResponseStatusEnum COMPLETED = _$transactionStatusResponseStatusEnum_COMPLETED;
  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const TransactionStatusResponseStatusEnum FAILED = _$transactionStatusResponseStatusEnum_FAILED;
  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'COMPENSATING')
  static const TransactionStatusResponseStatusEnum COMPENSATING = _$transactionStatusResponseStatusEnum_COMPENSATING;
  /// Current workflow status
  @BuiltValueEnumConst(wireName: r'UNKNOWN')
  static const TransactionStatusResponseStatusEnum UNKNOWN = _$transactionStatusResponseStatusEnum_UNKNOWN;

  static Serializer<TransactionStatusResponseStatusEnum> get serializer => _$transactionStatusResponseStatusEnumSerializer;

  const TransactionStatusResponseStatusEnum._(String name): super(name);

  static BuiltSet<TransactionStatusResponseStatusEnum> get values => _$transactionStatusResponseStatusEnumValues;
  static TransactionStatusResponseStatusEnum valueOf(String name) => _$transactionStatusResponseStatusEnumValueOf(name);
}

class TransactionStatusResponseActionCodeEnum extends EnumClass {

  /// Recommended action for failed transactions
  @BuiltValueEnumConst(wireName: r'DECLINE')
  static const TransactionStatusResponseActionCodeEnum DECLINE = _$transactionStatusResponseActionCodeEnum_DECLINE;
  /// Recommended action for failed transactions
  @BuiltValueEnumConst(wireName: r'RETRY')
  static const TransactionStatusResponseActionCodeEnum RETRY = _$transactionStatusResponseActionCodeEnum_RETRY;
  /// Recommended action for failed transactions
  @BuiltValueEnumConst(wireName: r'REVIEW')
  static const TransactionStatusResponseActionCodeEnum REVIEW = _$transactionStatusResponseActionCodeEnum_REVIEW;

  static Serializer<TransactionStatusResponseActionCodeEnum> get serializer => _$transactionStatusResponseActionCodeEnumSerializer;

  const TransactionStatusResponseActionCodeEnum._(String name): super(name);

  static BuiltSet<TransactionStatusResponseActionCodeEnum> get values => _$transactionStatusResponseActionCodeEnumValues;
  static TransactionStatusResponseActionCodeEnum valueOf(String name) => _$transactionStatusResponseActionCodeEnumValueOf(name);
}

