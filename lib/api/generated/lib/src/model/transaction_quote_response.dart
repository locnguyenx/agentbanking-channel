//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_quote_response.g.dart';

/// TransactionQuoteResponse
///
/// Properties:
/// * [quoteId] 
/// * [amount] 
/// * [fee] 
/// * [total] 
/// * [commission] 
@BuiltValue()
abstract class TransactionQuoteResponse implements Built<TransactionQuoteResponse, TransactionQuoteResponseBuilder> {
  @BuiltValueField(wireName: r'quoteId')
  String get quoteId;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'fee')
  String get fee;

  @BuiltValueField(wireName: r'total')
  String get total;

  @BuiltValueField(wireName: r'commission')
  String get commission;

  TransactionQuoteResponse._();

  factory TransactionQuoteResponse([void updates(TransactionQuoteResponseBuilder b)]) = _$TransactionQuoteResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionQuoteResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionQuoteResponse> get serializer => _$TransactionQuoteResponseSerializer();
}

class _$TransactionQuoteResponseSerializer implements PrimitiveSerializer<TransactionQuoteResponse> {
  @override
  final Iterable<Type> types = const [TransactionQuoteResponse, _$TransactionQuoteResponse];

  @override
  final String wireName = r'TransactionQuoteResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionQuoteResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'quoteId';
    yield serializers.serialize(
      object.quoteId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'fee';
    yield serializers.serialize(
      object.fee,
      specifiedType: const FullType(String),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(String),
    );
    yield r'commission';
    yield serializers.serialize(
      object.commission,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionQuoteResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TransactionQuoteResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'quoteId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.quoteId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'fee':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fee = valueDes;
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.total = valueDes;
          break;
        case r'commission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.commission = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionQuoteResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionQuoteResponseBuilder();
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

