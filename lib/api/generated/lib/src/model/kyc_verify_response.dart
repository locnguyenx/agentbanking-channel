//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'kyc_verify_response.g.dart';

/// KycVerifyResponse
///
/// Properties:
/// * [verificationId] 
/// * [status] 
/// * [fullName] 
/// * [dateOfBirth] 
/// * [age] 
/// * [amlStatus] 
/// * [message] 
/// * [kycLevel] 
/// * [expiresAt] 
@BuiltValue()
abstract class KycVerifyResponse implements Built<KycVerifyResponse, KycVerifyResponseBuilder> {
  @BuiltValueField(wireName: r'verificationId')
  String? get verificationId;

  @BuiltValueField(wireName: r'status')
  KycVerifyResponseStatusEnum? get status;
  // enum statusEnum {  VERIFIED,  PENDING,  FAILED,  FOUND,  };

  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  @BuiltValueField(wireName: r'dateOfBirth')
  String? get dateOfBirth;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'amlStatus')
  String? get amlStatus;

  @BuiltValueField(wireName: r'message')
  String? get message;

  @BuiltValueField(wireName: r'kycLevel')
  KycVerifyResponseKycLevelEnum? get kycLevel;
  // enum kycLevelEnum {  BASIC,  INTERMEDIATE,  ADVANCED,  };

  @BuiltValueField(wireName: r'expiresAt')
  DateTime? get expiresAt;

  KycVerifyResponse._();

  factory KycVerifyResponse([void updates(KycVerifyResponseBuilder b)]) = _$KycVerifyResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KycVerifyResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KycVerifyResponse> get serializer => _$KycVerifyResponseSerializer();
}

class _$KycVerifyResponseSerializer implements PrimitiveSerializer<KycVerifyResponse> {
  @override
  final Iterable<Type> types = const [KycVerifyResponse, _$KycVerifyResponse];

  @override
  final String wireName = r'KycVerifyResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KycVerifyResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.verificationId != null) {
      yield r'verificationId';
      yield serializers.serialize(
        object.verificationId,
        specifiedType: const FullType(String),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(KycVerifyResponseStatusEnum),
      );
    }
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
    if (object.dateOfBirth != null) {
      yield r'dateOfBirth';
      yield serializers.serialize(
        object.dateOfBirth,
        specifiedType: const FullType(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(int),
      );
    }
    if (object.amlStatus != null) {
      yield r'amlStatus';
      yield serializers.serialize(
        object.amlStatus,
        specifiedType: const FullType(String),
      );
    }
    if (object.message != null) {
      yield r'message';
      yield serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      );
    }
    if (object.kycLevel != null) {
      yield r'kycLevel';
      yield serializers.serialize(
        object.kycLevel,
        specifiedType: const FullType(KycVerifyResponseKycLevelEnum),
      );
    }
    if (object.expiresAt != null) {
      yield r'expiresAt';
      yield serializers.serialize(
        object.expiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    KycVerifyResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KycVerifyResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'verificationId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.verificationId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KycVerifyResponseStatusEnum),
          ) as KycVerifyResponseStatusEnum;
          result.status = valueDes;
          break;
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        case r'dateOfBirth':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dateOfBirth = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.age = valueDes;
          break;
        case r'amlStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amlStatus = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        case r'kycLevel':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KycVerifyResponseKycLevelEnum),
          ) as KycVerifyResponseKycLevelEnum;
          result.kycLevel = valueDes;
          break;
        case r'expiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KycVerifyResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KycVerifyResponseBuilder();
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

class KycVerifyResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'VERIFIED')
  static const KycVerifyResponseStatusEnum VERIFIED = _$kycVerifyResponseStatusEnum_VERIFIED;
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const KycVerifyResponseStatusEnum PENDING = _$kycVerifyResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'FAILED')
  static const KycVerifyResponseStatusEnum FAILED = _$kycVerifyResponseStatusEnum_FAILED;
  @BuiltValueEnumConst(wireName: r'FOUND')
  static const KycVerifyResponseStatusEnum FOUND = _$kycVerifyResponseStatusEnum_FOUND;

  static Serializer<KycVerifyResponseStatusEnum> get serializer => _$kycVerifyResponseStatusEnumSerializer;

  const KycVerifyResponseStatusEnum._(String name): super(name);

  static BuiltSet<KycVerifyResponseStatusEnum> get values => _$kycVerifyResponseStatusEnumValues;
  static KycVerifyResponseStatusEnum valueOf(String name) => _$kycVerifyResponseStatusEnumValueOf(name);
}

class KycVerifyResponseKycLevelEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BASIC')
  static const KycVerifyResponseKycLevelEnum BASIC = _$kycVerifyResponseKycLevelEnum_BASIC;
  @BuiltValueEnumConst(wireName: r'INTERMEDIATE')
  static const KycVerifyResponseKycLevelEnum INTERMEDIATE = _$kycVerifyResponseKycLevelEnum_INTERMEDIATE;
  @BuiltValueEnumConst(wireName: r'ADVANCED')
  static const KycVerifyResponseKycLevelEnum ADVANCED = _$kycVerifyResponseKycLevelEnum_ADVANCED;

  static Serializer<KycVerifyResponseKycLevelEnum> get serializer => _$kycVerifyResponseKycLevelEnumSerializer;

  const KycVerifyResponseKycLevelEnum._(String name): super(name);

  static BuiltSet<KycVerifyResponseKycLevelEnum> get values => _$kycVerifyResponseKycLevelEnumValues;
  static KycVerifyResponseKycLevelEnum valueOf(String name) => _$kycVerifyResponseKycLevelEnumValueOf(name);
}

