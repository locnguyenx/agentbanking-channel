//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'agent_response.g.dart';

/// AgentResponse
///
/// Properties:
/// * [agentId] 
/// * [agentCode] 
/// * [businessName] 
/// * [tier] 
/// * [status] 
/// * [merchantGpsLat] 
/// * [merchantGpsLng] 
/// * [phoneNumber] 
/// * [email] 
/// * [address] 
/// * [createdAt] 
/// * [updatedAt] 
@BuiltValue()
abstract class AgentResponse implements Built<AgentResponse, AgentResponseBuilder> {
  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'agentCode')
  String? get agentCode;

  @BuiltValueField(wireName: r'businessName')
  String? get businessName;

  @BuiltValueField(wireName: r'tier')
  AgentResponseTierEnum? get tier;
  // enum tierEnum {  MICRO,  STANDARD,  PREMIER,  };

  @BuiltValueField(wireName: r'status')
  AgentResponseStatusEnum? get status;
  // enum statusEnum {  ACTIVE,  INACTIVE,  PENDING,  SUSPENDED,  };

  @BuiltValueField(wireName: r'merchantGpsLat')
  num? get merchantGpsLat;

  @BuiltValueField(wireName: r'merchantGpsLng')
  num? get merchantGpsLng;

  @BuiltValueField(wireName: r'phoneNumber')
  String? get phoneNumber;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'address')
  String? get address;

  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  @BuiltValueField(wireName: r'updatedAt')
  DateTime? get updatedAt;

  AgentResponse._();

  factory AgentResponse([void updates(AgentResponseBuilder b)]) = _$AgentResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AgentResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AgentResponse> get serializer => _$AgentResponseSerializer();
}

class _$AgentResponseSerializer implements PrimitiveSerializer<AgentResponse> {
  @override
  final Iterable<Type> types = const [AgentResponse, _$AgentResponse];

  @override
  final String wireName = r'AgentResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AgentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentCode != null) {
      yield r'agentCode';
      yield serializers.serialize(
        object.agentCode,
        specifiedType: const FullType(String),
      );
    }
    if (object.businessName != null) {
      yield r'businessName';
      yield serializers.serialize(
        object.businessName,
        specifiedType: const FullType(String),
      );
    }
    if (object.tier != null) {
      yield r'tier';
      yield serializers.serialize(
        object.tier,
        specifiedType: const FullType(AgentResponseTierEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(AgentResponseStatusEnum),
      );
    }
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
    AgentResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AgentResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.agentId = valueDes;
          break;
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
            specifiedType: const FullType(AgentResponseTierEnum),
          ) as AgentResponseTierEnum;
          result.tier = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AgentResponseStatusEnum),
          ) as AgentResponseStatusEnum;
          result.status = valueDes;
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
  AgentResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AgentResponseBuilder();
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

class AgentResponseTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MICRO')
  static const AgentResponseTierEnum MICRO = _$agentResponseTierEnum_MICRO;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const AgentResponseTierEnum STANDARD = _$agentResponseTierEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const AgentResponseTierEnum PREMIER = _$agentResponseTierEnum_PREMIER;

  static Serializer<AgentResponseTierEnum> get serializer => _$agentResponseTierEnumSerializer;

  const AgentResponseTierEnum._(String name): super(name);

  static BuiltSet<AgentResponseTierEnum> get values => _$agentResponseTierEnumValues;
  static AgentResponseTierEnum valueOf(String name) => _$agentResponseTierEnumValueOf(name);
}

class AgentResponseStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ACTIVE')
  static const AgentResponseStatusEnum ACTIVE = _$agentResponseStatusEnum_ACTIVE;
  @BuiltValueEnumConst(wireName: r'INACTIVE')
  static const AgentResponseStatusEnum INACTIVE = _$agentResponseStatusEnum_INACTIVE;
  @BuiltValueEnumConst(wireName: r'PENDING')
  static const AgentResponseStatusEnum PENDING = _$agentResponseStatusEnum_PENDING;
  @BuiltValueEnumConst(wireName: r'SUSPENDED')
  static const AgentResponseStatusEnum SUSPENDED = _$agentResponseStatusEnum_SUSPENDED;

  static Serializer<AgentResponseStatusEnum> get serializer => _$agentResponseStatusEnumSerializer;

  const AgentResponseStatusEnum._(String name): super(name);

  static BuiltSet<AgentResponseStatusEnum> get values => _$agentResponseStatusEnumValues;
  static AgentResponseStatusEnum valueOf(String name) => _$agentResponseStatusEnumValueOf(name);
}

