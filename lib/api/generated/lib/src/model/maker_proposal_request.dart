//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'maker_proposal_request.g.dart';

/// MakerProposalRequest
///
/// Properties:
/// * [action] - Proposed action for the transaction
/// * [reasonCode] - Reason code for the proposal
/// * [reason] - Detailed reason for the proposal
/// * [evidenceUrl] - URL to supporting evidence
@BuiltValue()
abstract class MakerProposalRequest implements Built<MakerProposalRequest, MakerProposalRequestBuilder> {
  /// Proposed action for the transaction
  @BuiltValueField(wireName: r'action')
  MakerProposalRequestActionEnum get action;
  // enum actionEnum {  COMMIT,  ROLLBACK,  ESCALATE,  };

  /// Reason code for the proposal
  @BuiltValueField(wireName: r'reasonCode')
  String? get reasonCode;

  /// Detailed reason for the proposal
  @BuiltValueField(wireName: r'reason')
  String? get reason;

  /// URL to supporting evidence
  @BuiltValueField(wireName: r'evidenceUrl')
  String? get evidenceUrl;

  MakerProposalRequest._();

  factory MakerProposalRequest([void updates(MakerProposalRequestBuilder b)]) = _$MakerProposalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MakerProposalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MakerProposalRequest> get serializer => _$MakerProposalRequestSerializer();
}

class _$MakerProposalRequestSerializer implements PrimitiveSerializer<MakerProposalRequest> {
  @override
  final Iterable<Type> types = const [MakerProposalRequest, _$MakerProposalRequest];

  @override
  final String wireName = r'MakerProposalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MakerProposalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(MakerProposalRequestActionEnum),
    );
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
  }

  @override
  Object serialize(
    Serializers serializers,
    MakerProposalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MakerProposalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MakerProposalRequestActionEnum),
          ) as MakerProposalRequestActionEnum;
          result.action = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MakerProposalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MakerProposalRequestBuilder();
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

class MakerProposalRequestActionEnum extends EnumClass {

  /// Proposed action for the transaction
  @BuiltValueEnumConst(wireName: r'COMMIT')
  static const MakerProposalRequestActionEnum COMMIT = _$makerProposalRequestActionEnum_COMMIT;
  /// Proposed action for the transaction
  @BuiltValueEnumConst(wireName: r'ROLLBACK')
  static const MakerProposalRequestActionEnum ROLLBACK = _$makerProposalRequestActionEnum_ROLLBACK;
  /// Proposed action for the transaction
  @BuiltValueEnumConst(wireName: r'ESCALATE')
  static const MakerProposalRequestActionEnum ESCALATE = _$makerProposalRequestActionEnum_ESCALATE;

  static Serializer<MakerProposalRequestActionEnum> get serializer => _$makerProposalRequestActionEnumSerializer;

  const MakerProposalRequestActionEnum._(String name): super(name);

  static BuiltSet<MakerProposalRequestActionEnum> get values => _$makerProposalRequestActionEnumValues;
  static MakerProposalRequestActionEnum valueOf(String name) => _$makerProposalRequestActionEnumValueOf(name);
}

