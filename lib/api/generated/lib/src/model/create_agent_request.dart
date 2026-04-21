//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_agent_request.g.dart';

/// CreateAgentRequest
///
/// Properties:
/// * [agentCode]
/// * [businessName]
/// * [tier]
/// * [merchantGpsLat]
/// * [merchantGpsLng]
/// * [mykadNumber]
/// * [phoneNumber]
@BuiltValue()
abstract class CreateAgentRequest
    implements Built<CreateAgentRequest, CreateAgentRequestBuilder> {
  @BuiltValueField(wireName: r'agentCode')
  String get agentCode;

  @BuiltValueField(wireName: r'businessName')
  String get businessName;

  @BuiltValueField(wireName: r'tier')
  CreateAgentRequestTierEnum get tier;
  // enum tierEnum {  BASIC,  STANDARD,  PREMIER,  };

  @BuiltValueField(wireName: r'merchantGpsLat')
  num get merchantGpsLat;

  @BuiltValueField(wireName: r'merchantGpsLng')
  num get merchantGpsLng;

  @BuiltValueField(wireName: r'mykadNumber')
  String get mykadNumber;

  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  CreateAgentRequest._();

  factory CreateAgentRequest([void updates(CreateAgentRequestBuilder b)]) =
      _$CreateAgentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAgentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAgentRequest> get serializer =>
      _$CreateAgentRequestSerializer();
}

class _$CreateAgentRequestSerializer
    implements PrimitiveSerializer<CreateAgentRequest> {
  @override
  final Iterable<Type> types = const [CreateAgentRequest, _$CreateAgentRequest];

  @override
  final String wireName = r'CreateAgentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAgentRequest object, {
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
      specifiedType: const FullType(CreateAgentRequestTierEnum),
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
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAgentRequest object, {
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
    required CreateAgentRequestBuilder result,
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
            specifiedType: const FullType(CreateAgentRequestTierEnum),
          ) as CreateAgentRequestTierEnum;
          result.tier = valueDes;
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAgentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAgentRequestBuilder();
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

class CreateAgentRequestTierEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'BASIC')
  static const CreateAgentRequestTierEnum BASIC =
      _$createAgentRequestTierEnum_BASIC;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const CreateAgentRequestTierEnum STANDARD =
      _$createAgentRequestTierEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const CreateAgentRequestTierEnum PREMIER =
      _$createAgentRequestTierEnum_PREMIER;

  static Serializer<CreateAgentRequestTierEnum> get serializer =>
      _$createAgentRequestTierEnumSerializer;

  const CreateAgentRequestTierEnum._(String name) : super(name);

  static BuiltSet<CreateAgentRequestTierEnum> get values =>
      _$createAgentRequestTierEnumValues;
  static CreateAgentRequestTierEnum valueOf(String name) =>
      _$createAgentRequestTierEnumValueOf(name);
}
