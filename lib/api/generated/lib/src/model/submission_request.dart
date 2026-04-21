//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'submission_request.g.dart';

/// SubmissionRequest
///
/// Properties:
/// * [mykadNumber] 
/// * [extractedName] 
/// * [ssmBusinessName] 
/// * [ssmOwnerName] 
/// * [agentTier] 
/// * [merchantGpsLat] 
/// * [merchantGpsLng] 
/// * [phoneNumber] 
@BuiltValue()
abstract class SubmissionRequest implements Built<SubmissionRequest, SubmissionRequestBuilder> {
  @BuiltValueField(wireName: r'mykadNumber')
  String get mykadNumber;

  @BuiltValueField(wireName: r'extractedName')
  String get extractedName;

  @BuiltValueField(wireName: r'ssmBusinessName')
  String get ssmBusinessName;

  @BuiltValueField(wireName: r'ssmOwnerName')
  String get ssmOwnerName;

  @BuiltValueField(wireName: r'agentTier')
  SubmissionRequestAgentTierEnum get agentTier;
  // enum agentTierEnum {  MICRO,  STANDARD,  PREMIER,  };

  @BuiltValueField(wireName: r'merchantGpsLat')
  num? get merchantGpsLat;

  @BuiltValueField(wireName: r'merchantGpsLng')
  num? get merchantGpsLng;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  SubmissionRequest._();

  factory SubmissionRequest([void updates(SubmissionRequestBuilder b)]) = _$SubmissionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SubmissionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SubmissionRequest> get serializer => _$SubmissionRequestSerializer();
}

class _$SubmissionRequestSerializer implements PrimitiveSerializer<SubmissionRequest> {
  @override
  final Iterable<Type> types = const [SubmissionRequest, _$SubmissionRequest];

  @override
  final String wireName = r'SubmissionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'mykadNumber';
    yield serializers.serialize(
      object.mykadNumber,
      specifiedType: const FullType(String),
    );
    yield r'extractedName';
    yield serializers.serialize(
      object.extractedName,
      specifiedType: const FullType(String),
    );
    yield r'ssmBusinessName';
    yield serializers.serialize(
      object.ssmBusinessName,
      specifiedType: const FullType(String),
    );
    yield r'ssmOwnerName';
    yield serializers.serialize(
      object.ssmOwnerName,
      specifiedType: const FullType(String),
    );
    yield r'agentTier';
    yield serializers.serialize(
      object.agentTier,
      specifiedType: const FullType(SubmissionRequestAgentTierEnum),
    );
    if (object.merchantGpsLat != null) {
      yield r'merchantGpsLat';
      yield serializers.serialize(
        object.merchantGpsLat,
        specifiedType: const FullType(num),
      );
    }
    if (object.merchantGpsLng != null) {
      yield r'merchantGpsLng';
      yield serializers.serialize(
        object.merchantGpsLng,
        specifiedType: const FullType(num),
      );
    }
    if (object.phoneNumber != null) {
      yield r'phoneNumber';
      yield serializers.serialize(
        object.phoneNumber,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    SubmissionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SubmissionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'mykadNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mykadNumber = valueDes;
          break;
        case r'extractedName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.extractedName = valueDes;
          break;
        case r'ssmBusinessName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ssmBusinessName = valueDes;
          break;
        case r'ssmOwnerName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ssmOwnerName = valueDes;
          break;
        case r'agentTier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(SubmissionRequestAgentTierEnum),
          ) as SubmissionRequestAgentTierEnum;
          result.agentTier = valueDes;
          break;
        case r'merchantGpsLat':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.merchantGpsLat = valueDes;
          break;
        case r'merchantGpsLng':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.merchantGpsLng = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phoneNumber = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SubmissionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SubmissionRequestBuilder();
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

class SubmissionRequestAgentTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MICRO')
  static const SubmissionRequestAgentTierEnum MICRO = _$submissionRequestAgentTierEnum_MICRO;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const SubmissionRequestAgentTierEnum STANDARD = _$submissionRequestAgentTierEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const SubmissionRequestAgentTierEnum PREMIER = _$submissionRequestAgentTierEnum_PREMIER;

  static Serializer<SubmissionRequestAgentTierEnum> get serializer => _$submissionRequestAgentTierEnumSerializer;

  const SubmissionRequestAgentTierEnum._(String name): super(name);

  static BuiltSet<SubmissionRequestAgentTierEnum> get values => _$submissionRequestAgentTierEnumValues;
  static SubmissionRequestAgentTierEnum valueOf(String name) => _$submissionRequestAgentTierEnumValueOf(name);
}

