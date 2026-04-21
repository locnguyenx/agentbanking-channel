//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'backoffice_transaction_list_response.g.dart';

/// BackofficeTransactionListResponse
///
/// Properties:
/// * [content] 
/// * [total] 
@BuiltValue()
abstract class BackofficeTransactionListResponse implements Built<BackofficeTransactionListResponse, BackofficeTransactionListResponseBuilder> {
  @BuiltValueField(wireName: r'content')
  BuiltList<BuiltMap<String, JsonObject?>>? get content;

  @BuiltValueField(wireName: r'total')
  int? get total;

  BackofficeTransactionListResponse._();

  factory BackofficeTransactionListResponse([void updates(BackofficeTransactionListResponseBuilder b)]) = _$BackofficeTransactionListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BackofficeTransactionListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BackofficeTransactionListResponse> get serializer => _$BackofficeTransactionListResponseSerializer();
}

class _$BackofficeTransactionListResponseSerializer implements PrimitiveSerializer<BackofficeTransactionListResponse> {
  @override
  final Iterable<Type> types = const [BackofficeTransactionListResponse, _$BackofficeTransactionListResponse];

  @override
  final String wireName = r'BackofficeTransactionListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BackofficeTransactionListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
      );
    }
    if (object.total != null) {
      yield r'total';
      yield serializers.serialize(
        object.total,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BackofficeTransactionListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BackofficeTransactionListResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(BuiltMap, [FullType(String), FullType.nullable(JsonObject)])]),
          ) as BuiltList<BuiltMap<String, JsonObject?>>;
          result.content.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BackofficeTransactionListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BackofficeTransactionListResponseBuilder();
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

