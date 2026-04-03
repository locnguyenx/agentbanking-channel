//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'application_submit_response.g.dart';

/// ApplicationSubmitResponse
///
/// Properties:
/// * [applicationId]
/// * [status]
/// * [message]
/// * [submittedAt]
@BuiltValue()
abstract class ApplicationSubmitResponse
    implements
        Built<ApplicationSubmitResponse, ApplicationSubmitResponseBuilder> {
  @BuiltValueField(wireName: r'applicationId')
  String? get applicationId;

  @BuiltValueField(wireName: r'status')
  ApplicationSubmitResponseStatusEnum? get status;
  // enum statusEnum {  SUBMITTED,  PENDING_REVIEW,  APPROVED,  REJECTED,  };

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'submittedAt')
  DateTime? get submittedAt;

  ApplicationSubmitResponse._();

  factory ApplicationSubmitResponse(
          [void updates(ApplicationSubmitResponseBuilder b)]) =
      _$ApplicationSubmitResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApplicationSubmitResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApplicationSubmitResponse> get serializer =>
      _$ApplicationSubmitResponseSerializer();
}

class _$ApplicationSubmitResponseSerializer
    implements PrimitiveSerializer<ApplicationSubmitResponse> {
  @override
  final Iterable<Type> types = const [
    ApplicationSubmitResponse,
    _$ApplicationSubmitResponse
  ];

  @override
  final String wireName = r'ApplicationSubmitResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApplicationSubmitResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.applicationId != null) {
      yield r'applicationId';
      yield serializers.serialize(
        object.applicationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ApplicationSubmitResponseStatusEnum),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.submittedAt != null) {
      yield r'submittedAt';
      yield serializers.serialize(
        object.submittedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ApplicationSubmitResponse object, {
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
    required ApplicationSubmitResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'applicationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.applicationId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ApplicationSubmitResponseStatusEnum),
          ) as ApplicationSubmitResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'submittedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.submittedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ApplicationSubmitResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApplicationSubmitResponseBuilder();
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

class ApplicationSubmitResponseStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'SUBMITTED')
  static const ApplicationSubmitResponseStatusEnum SUBMITTED =
      _$applicationSubmitResponseStatusEnum_SUBMITTED;
  @BuiltValueEnumConst(wireName: r'PENDING_REVIEW')
  static const ApplicationSubmitResponseStatusEnum PENDING_REVIEW =
      _$applicationSubmitResponseStatusEnum_PENDING_REVIEW;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const ApplicationSubmitResponseStatusEnum APPROVED =
      _$applicationSubmitResponseStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const ApplicationSubmitResponseStatusEnum REJECTED =
      _$applicationSubmitResponseStatusEnum_REJECTED;

  static Serializer<ApplicationSubmitResponseStatusEnum> get serializer =>
      _$applicationSubmitResponseStatusEnumSerializer;

  const ApplicationSubmitResponseStatusEnum._(String name) : super(name);

  static BuiltSet<ApplicationSubmitResponseStatusEnum> get values =>
      _$applicationSubmitResponseStatusEnumValues;
  static ApplicationSubmitResponseStatusEnum valueOf(String name) =>
      _$applicationSubmitResponseStatusEnumValueOf(name);
}
