//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:agent_api/src/model/audit_log_record.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'backoffice_audit_log_list_response.g.dart';

/// BackofficeAuditLogListResponse
///
/// Properties:
/// * [content] 
/// * [totalElements] 
/// * [totalPages] 
/// * [page] 
/// * [size] 
@BuiltValue()
abstract class BackofficeAuditLogListResponse implements Built<BackofficeAuditLogListResponse, BackofficeAuditLogListResponseBuilder> {
  @BuiltValueField(wireName: r'content')
  BuiltList<AuditLogRecord>? get content;

  @BuiltValueField(wireName: r'totalElements')
  int? get totalElements;

  @BuiltValueField(wireName: r'totalPages')
  int? get totalPages;

  @BuiltValueField(wireName: r'page')
  int? get page;

  @BuiltValueField(wireName: r'size')
  int? get size;

  BackofficeAuditLogListResponse._();

  factory BackofficeAuditLogListResponse([void updates(BackofficeAuditLogListResponseBuilder b)]) = _$BackofficeAuditLogListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BackofficeAuditLogListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BackofficeAuditLogListResponse> get serializer => _$BackofficeAuditLogListResponseSerializer();
}

class _$BackofficeAuditLogListResponseSerializer implements PrimitiveSerializer<BackofficeAuditLogListResponse> {
  @override
  final Iterable<Type> types = const [BackofficeAuditLogListResponse, _$BackofficeAuditLogListResponse];

  @override
  final String wireName = r'BackofficeAuditLogListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BackofficeAuditLogListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.content != null) {
      yield r'content';
      yield serializers.serialize(
        object.content,
        specifiedType: const FullType(BuiltList, [FullType(AuditLogRecord)]),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    BackofficeAuditLogListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BackofficeAuditLogListResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AuditLogRecord)]),
          ) as BuiltList<AuditLogRecord>;
          result.content.replace(valueDes);
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BackofficeAuditLogListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BackofficeAuditLogListResponseBuilder();
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

