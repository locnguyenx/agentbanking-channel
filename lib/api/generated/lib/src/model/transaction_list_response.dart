//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/transaction_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_list_response.g.dart';

/// TransactionListResponse
///
/// Properties:
/// * [transactions]
/// * [page]
/// * [size]
/// * [totalElements]
/// * [totalPages]
@BuiltValue()
abstract class TransactionListResponse
    implements Built<TransactionListResponse, TransactionListResponseBuilder> {
  @BuiltValueField(wireName: r'transactions')
  BuiltList<TransactionResponse>? get transactions;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'size')
  int? get size;

  @BuiltValueField(wireName: r'totalElements')
  int? get totalElements;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  TransactionListResponse._();

  factory TransactionListResponse(
          [void updates(TransactionListResponseBuilder b)]) =
      _$TransactionListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TransactionListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TransactionListResponse> get serializer =>
      _$TransactionListResponseSerializer();
}

class _$TransactionListResponseSerializer
    implements PrimitiveSerializer<TransactionListResponse> {
  @override
  final Iterable<Type> types = const [
    TransactionListResponse,
    _$TransactionListResponse
  ];

  @override
  final String wireName = r'TransactionListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TransactionListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.transactions != null) {
      yield r'transactions';
      yield serializers.serialize(
        object.transactions,
        specifiedType:
            const FullType(BuiltList, [FullType(TransactionResponse)]),
      );
    }
    if (object.page != null) {
      yield r'page';
      yield serializers.serialize(
        object.page,
        specifiedType: const FullType(int),
      );
    }
    if (object.size != null) {
      yield r'size';
      yield serializers.serialize(
        object.size,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalElements != null) {
      yield r'totalElements';
      yield serializers.serialize(
        object.totalElements,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalPages != null) {
      yield r'totalPages';
      yield serializers.serialize(
        object.totalPages,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TransactionListResponse object, {
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
    required TransactionListResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'transactions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(TransactionResponse)]),
          ) as BuiltList<TransactionResponse>;
          result.transactions.replace(valueDes);
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.size = valueDes;
          break;
        case r'totalElements':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalElements = valueDes;
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalPages = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TransactionListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TransactionListResponseBuilder();
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
