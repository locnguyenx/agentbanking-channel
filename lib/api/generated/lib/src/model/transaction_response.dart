//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_response.g.dart';

/// TransactionResponse
///
/// Properties:
/// * [status]
/// * [transactionId]
/// * [amount]
/// * [currency]
/// * [transactionType]
/// * [timestamp]
/// * [message]
/// * [reference]
@BuiltValue()
abstract class TransactionResponse
    implements Built<TransactionResponse, TransactionResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  TransactionResponseStatusEnum? get status;
  // enum statusEnum {  SUCCESS,  PENDING,  FAILED,  };

  @BuiltValueField(wireName: r'transactionId')
  String? get transactionId;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'transactionType')
  String? get transactionType;

  @BuiltValueField(wireName: r'timestamp')
  DateTime? get timestamp;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'reference')
  String? get reference;

  TransactionResponse._();

  factory TransactionResponse([void updates(TransactionResponseBuilder b)]) =
      _$TransactionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionResponse> get serializer =>
      _$TransactionResponseSerializer();
}

class _$TransactionResponseSerializer
    implements PrimitiveSerializer<TransactionResponse> {
  @override
  final Iterable<Type> types = const [
    TransactionResponse,
    _$TransactionResponse
  ];

  @override
  final String wireName = r'TransactionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TransactionResponseStatusEnum),
      );
    }
    if (object.transactionId != null) {
      yield r'transactionId';
      yield serializers.serialize(
        object.transactionId,
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
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionType != null) {
      yield r'transactionType';
      yield serializers.serialize(
        object.transactionType,
        specifiedType: const FullType(String),
      );
    }
    if (object.timestamp != null) {
      yield r'timestamp';
      yield serializers.serialize(
        object.timestamp,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.reference != null) {
      yield r'reference';
      yield serializers.serialize(
        object.reference,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionResponse object, {
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
    required TransactionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionResponseStatusEnum),
          ) as TransactionResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'transactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'transactionType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionType = valueDes;
          break;
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'reference':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reference = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionResponseBuilder();
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

class TransactionResponseStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'SUCCESS')
  static const TransactionResponseStatusEnum SUCCESS =
      _$transactionResponseStatusEnum_SUCCESS;
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const TransactionResponseStatusEnum PENDING =
      _$transactionResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const TransactionResponseStatusEnum FAILED =
      _$transactionResponseStatusEnum_FAILED;

  static Serializer<TransactionResponseStatusEnum> get serializer =>
      _$transactionResponseStatusEnumSerializer;

  const TransactionResponseStatusEnum._(String name) : super(name);

  static BuiltSet<TransactionResponseStatusEnum> get values =>
      _$transactionResponseStatusEnumValues;
  static TransactionResponseStatusEnum valueOf(String name) =>
      _$transactionResponseStatusEnumValueOf(name);
}
