//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_start_response.g.dart';

/// TransactionStartResponse
///
/// Properties:
/// * [status] - Initial status of the transaction
/// * [workflowId] - Unique workflow identifier for polling status
/// * [pollUrl] - URL to poll for transaction status
@BuiltValue()
abstract class TransactionStartResponse implements Built<TransactionStartResponse, TransactionStartResponseBuilder> {
  /// Initial status of the transaction
  @BuiltValueField(wireName: r'status')
  TransactionStartResponseStatusEnum? get status;
  // enum statusEnum {  PENDING,  };

  /// Unique workflow identifier for polling status
  @BuiltValueField(wireName: r'workflowId')
  String? get workflowId;

  /// URL to poll for transaction status
  @BuiltValueField(wireName: r'pollUrl')
  String? get pollUrl;

  TransactionStartResponse._();

  factory TransactionStartResponse([void updates(TransactionStartResponseBuilder b)]) = _$TransactionStartResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionStartResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionStartResponse> get serializer => _$TransactionStartResponseSerializer();
}

class _$TransactionStartResponseSerializer implements PrimitiveSerializer<TransactionStartResponse> {
  @override
  final Iterable<Type> types = const [TransactionStartResponse, _$TransactionStartResponse];

  @override
  final String wireName = r'TransactionStartResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionStartResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(TransactionStartResponseStatusEnum),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(String),
      );
    }
    if (object.pollUrl != null) {
      yield r'pollUrl';
      yield serializers.serialize(
        object.pollUrl,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionStartResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionStartResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TransactionStartResponseStatusEnum),
          ) as TransactionStartResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workflowId = valueDes;
          break;
        case r'pollUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pollUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionStartResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionStartResponseBuilder();
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

class TransactionStartResponseStatusEnum extends EnumClass {

  /// Initial status of the transaction
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const TransactionStartResponseStatusEnum PENDING = _$transactionStartResponseStatusEnum_PENDING;

  static Serializer<TransactionStartResponseStatusEnum> get serializer => _$transactionStartResponseStatusEnumSerializer;

  const TransactionStartResponseStatusEnum._(String name): super(name);

  static BuiltSet<TransactionStartResponseStatusEnum> get values => _$transactionStartResponseStatusEnumValues;
  static TransactionStartResponseStatusEnum valueOf(String name) => _$transactionStartResponseStatusEnumValueOf(name);
}

