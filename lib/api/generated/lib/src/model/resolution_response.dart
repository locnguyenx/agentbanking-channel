//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'resolution_response.g.dart';

/// ResolutionResponse
///
/// Properties:
/// * [id] 
/// * [workflowId] 
/// * [transactionId] 
/// * [proposedAction] 
/// * [reasonCode] 
/// * [reason] 
/// * [evidenceUrl] 
/// * [status] 
/// * [makerUserId] 
/// * [makerCreatedAt] 
/// * [checkerUserId] 
/// * [checkerAction] 
/// * [checkerReason] 
/// * [checkerCompletedAt] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class ResolutionResponse implements Built<ResolutionResponse, ResolutionResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String? get id;

  @BuiltValueField(wireName: r'workflowId')
  String? get workflowId;

  @BuiltValueField(wireName: r'transactionId')
  String? get transactionId;

  @BuiltValueField(wireName: r'proposedAction')
  ResolutionResponseProposedActionEnum? get proposedAction;
  // enum proposedActionEnum {  COMMIT,  ROLLBACK,  ESCALATE,  };

  @BuiltValueField(wireName: r'reasonCode')
  String? get reasonCode;

  @BuiltValueField(wireName: r'reason')
  String? get reason;

  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  @BuiltValueField(wireName: r'status')
  ResolutionResponseStatusEnum? get status;
  // enum statusEnum {  PENDING_MAKER,  PENDING_CHECKER,  APPROVED,  REJECTED,  };

  @BuiltValueField(wireName: r'makerUserId')
  String? get makerUserId;

  @BuiltValueField(wireName: r'makerCreatedAt')
  DateTime? get makerCreatedAt;

  @BuiltValueField(wireName: r'checkerUserId')
  String? get checkerUserId;

  @BuiltValueField(wireName: r'checkerAction')
  String? get checkerAction;

  @BuiltValueField(wireName: r'checkerReason')
  String? get checkerReason;

  @BuiltValueField(wireName: r'checkerCompletedAt')
  DateTime? get checkerCompletedAt;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  ResolutionResponse._();

  factory ResolutionResponse([void updates(ResolutionResponseBuilder b)]) = _$ResolutionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResolutionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResolutionResponse> get serializer => _$ResolutionResponseSerializer();
}

class _$ResolutionResponseSerializer implements PrimitiveSerializer<ResolutionResponse> {
  @override
  final Iterable<Type> types = const [ResolutionResponse, _$ResolutionResponse];

  @override
  final String wireName = r'ResolutionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResolutionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.workflowId != null) {
      yield r'workflowId';
      yield serializers.serialize(
        object.workflowId,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionId != null) {
      yield r'transactionId';
      yield serializers.serialize(
        object.transactionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.proposedAction != null) {
      yield r'proposedAction';
      yield serializers.serialize(
        object.proposedAction,
        specifiedType: const FullType(ResolutionResponseProposedActionEnum),
      );
    }
    if (object.reasonCode != null) {
      yield r'reasonCode';
      yield serializers.serialize(
        object.reasonCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.reason != null) {
      yield r'reason';
      yield serializers.serialize(
        object.reason,
        specifiedType: const FullType(String),
      );
    }
    if (object.evidenceUrl != null) {
      yield r'evidenceUrl';
      yield serializers.serialize(
        object.evidenceUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(ResolutionResponseStatusEnum),
      );
    }
    if (object.makerUserId != null) {
      yield r'makerUserId';
      yield serializers.serialize(
        object.makerUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.makerCreatedAt != null) {
      yield r'makerCreatedAt';
      yield serializers.serialize(
        object.makerCreatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.checkerUserId != null) {
      yield r'checkerUserId';
      yield serializers.serialize(
        object.checkerUserId,
        specifiedType: const FullType(String),
      );
    }
    if (object.checkerAction != null) {
      yield r'checkerAction';
      yield serializers.serialize(
        object.checkerAction,
        specifiedType: const FullType(String),
      );
    }
    if (object.checkerReason != null) {
      yield r'checkerReason';
      yield serializers.serialize(
        object.checkerReason,
        specifiedType: const FullType(String),
      );
    }
    if (object.checkerCompletedAt != null) {
      yield r'checkerCompletedAt';
      yield serializers.serialize(
        object.checkerCompletedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.updatedAt != null) {
      yield r'updatedAt';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ResolutionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResolutionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'workflowId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.workflowId = valueDes;
          break;
        case r'transactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionId = valueDes;
          break;
        case r'proposedAction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ResolutionResponseProposedActionEnum),
          ) as ResolutionResponseProposedActionEnum;
          result.proposedAction = valueDes;
          break;
        case r'reasonCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reasonCode = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'evidenceUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.evidenceUrl = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ResolutionResponseStatusEnum),
          ) as ResolutionResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'makerUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.makerUserId = valueDes;
          break;
        case r'makerCreatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.makerCreatedAt = valueDes;
          break;
        case r'checkerUserId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkerUserId = valueDes;
          break;
        case r'checkerAction':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkerAction = valueDes;
          break;
        case r'checkerReason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.checkerReason = valueDes;
          break;
        case r'checkerCompletedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.checkerCompletedAt = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'updatedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.updatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResolutionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResolutionResponseBuilder();
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

class ResolutionResponseProposedActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'COMMIT')
  static const ResolutionResponseProposedActionEnum COMMIT = _$resolutionResponseProposedActionEnum_COMMIT;
  @BuiltValueEnumConst(wireName: r'ROLLBACK')
  static const ResolutionResponseProposedActionEnum ROLLBACK = _$resolutionResponseProposedActionEnum_ROLLBACK;
  @BuiltValueEnumConst(wireName: r'ESCALATE')
  static const ResolutionResponseProposedActionEnum ESCALATE = _$resolutionResponseProposedActionEnum_ESCALATE;

  static Serializer<ResolutionResponseProposedActionEnum> get serializer => _$resolutionResponseProposedActionEnumSerializer;

  const ResolutionResponseProposedActionEnum._(String name): super(name);

  static BuiltSet<ResolutionResponseProposedActionEnum> get values => _$resolutionResponseProposedActionEnumValues;
  static ResolutionResponseProposedActionEnum valueOf(String name) => _$resolutionResponseProposedActionEnumValueOf(name);
}

class ResolutionResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PENDING_MAKER')
  static const ResolutionResponseStatusEnum PENDING_MAKER = _$resolutionResponseStatusEnum_PENDING_MAKER;
  @BuiltValueEnumConst(wireName: r'PENDING_CHECKER')
  static const ResolutionResponseStatusEnum PENDING_CHECKER = _$resolutionResponseStatusEnum_PENDING_CHECKER;
  @BuiltValueEnumConst(wireName: r'APPROVED')
  static const ResolutionResponseStatusEnum APPROVED = _$resolutionResponseStatusEnum_APPROVED;
  @BuiltValueEnumConst(wireName: r'REJECTED')
  static const ResolutionResponseStatusEnum REJECTED = _$resolutionResponseStatusEnum_REJECTED;

  static Serializer<ResolutionResponseStatusEnum> get serializer => _$resolutionResponseStatusEnumSerializer;

  const ResolutionResponseStatusEnum._(String name): super(name);

  static BuiltSet<ResolutionResponseStatusEnum> get values => _$resolutionResponseStatusEnumValues;
  static ResolutionResponseStatusEnum valueOf(String name) => _$resolutionResponseStatusEnumValueOf(name);
}

