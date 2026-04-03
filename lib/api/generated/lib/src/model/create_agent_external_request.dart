//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_agent_external_request.g.dart';

/// CreateAgentExternalRequest
///
/// Properties:
/// * [agentCode] - Unique agent code
/// * [businessName] - Business name
/// * [tier] - Agent tier level
/// * [mykadNumber] - MyKad number (NRIC)
/// * [phoneNumber] - Contact number
/// * [merchantGpsLat] - Merchant GPS latitude
/// * [merchantGpsLng] - Merchant GPS longitude
/// * [email]
/// * [address]
@BuiltValue()
abstract class CreateAgentExternalRequest
    implements
        Built<CreateAgentExternalRequest, CreateAgentExternalRequestBuilder> {
  /// Unique agent code
  @BuiltValueField(wireName: r'agentCode')
  String get agentCode;

  /// Business name
  @BuiltValueField(wireName: r'businessName')
  String get businessName;

  /// Agent tier level
  @BuiltValueField(wireName: r'tier')
  CreateAgentExternalRequestTierEnum get tier;
  // enum tierEnum {  MICRO,  STANDARD,  PREMIER,  };

  /// MyKad number (NRIC)
  @BuiltValueField(wireName: r'mykadNumber')
  String get mykadNumber;

  /// Contact number
  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  /// Merchant GPS latitude
  @BuiltValueField(wireName: r'merchantGpsLat')
  num get merchantGpsLat;

  /// Merchant GPS longitude
  @BuiltValueField(wireName: r'merchantGpsLng')
  num get merchantGpsLng;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'address')
  String? get address;

  CreateAgentExternalRequest._();

  factory CreateAgentExternalRequest(
          [void updates(CreateAgentExternalRequestBuilder b)]) =
      _$CreateAgentExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAgentExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAgentExternalRequest> get serializer =>
      _$CreateAgentExternalRequestSerializer();
}

class _$CreateAgentExternalRequestSerializer
    implements PrimitiveSerializer<CreateAgentExternalRequest> {
  @override
  final Iterable<Type> types = const [
    CreateAgentExternalRequest,
    _$CreateAgentExternalRequest
  ];

  @override
  final String wireName = r'CreateAgentExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAgentExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'agentCode';
    yield serializers.serialize(
      object.agentCode,
      specifiedType: const FullType(String),
    );
    yield r'businessName';
    yield serializers.serialize(
      object.businessName,
      specifiedType: const FullType(String),
    );
    yield r'tier';
    yield serializers.serialize(
      object.tier,
      specifiedType: const FullType(CreateAgentExternalRequestTierEnum),
    );
    yield r'mykadNumber';
    yield serializers.serialize(
      object.mykadNumber,
      specifiedType: const FullType(String),
    );
    yield r'phoneNumber';
    yield serializers.serialize(
      object.phoneNumber,
      specifiedType: const FullType(String),
    );
    yield r'merchantGpsLat';
    yield serializers.serialize(
      object.merchantGpsLat,
      specifiedType: const FullType(num),
    );
    yield r'merchantGpsLng';
    yield serializers.serialize(
      object.merchantGpsLng,
      specifiedType: const FullType(num),
    );
    if (object.email != null) {
      yield r'email';
      yield serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      );
    }
    if (object.address != null) {
      yield r'address';
      yield serializers.serialize(
        object.address,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAgentExternalRequest object, {
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
    required CreateAgentExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agentCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentCode = valueDes;
          break;
        case r'businessName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.businessName = valueDes;
          break;
        case r'tier':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateAgentExternalRequestTierEnum),
          ) as CreateAgentExternalRequestTierEnum;
          result.tier = valueDes;
          break;
        case r'mykadNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.mykadNumber = valueDes;
          break;
        case r'phoneNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phoneNumber = valueDes;
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAgentExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAgentExternalRequestBuilder();
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

class CreateAgentExternalRequestTierEnum extends EnumClass {
  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'MICRO')
  static const CreateAgentExternalRequestTierEnum MICRO =
      _$createAgentExternalRequestTierEnum_MICRO;

  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const CreateAgentExternalRequestTierEnum STANDARD =
      _$createAgentExternalRequestTierEnum_STANDARD;

  /// Agent tier level
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const CreateAgentExternalRequestTierEnum PREMIER =
      _$createAgentExternalRequestTierEnum_PREMIER;

  static Serializer<CreateAgentExternalRequestTierEnum> get serializer =>
      _$createAgentExternalRequestTierEnumSerializer;

  const CreateAgentExternalRequestTierEnum._(String name) : super(name);

  static BuiltSet<CreateAgentExternalRequestTierEnum> get values =>
      _$createAgentExternalRequestTierEnumValues;
  static CreateAgentExternalRequestTierEnum valueOf(String name) =>
      _$createAgentExternalRequestTierEnumValueOf(name);
}
