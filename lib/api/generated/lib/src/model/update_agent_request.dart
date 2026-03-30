// @dart=2.19
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_agent_request.g.dart';

/// UpdateAgentRequest
///
/// Properties:
/// * [businessName] 
/// * [tier] 
/// * [merchantGpsLat] 
/// * [merchantGpsLng] 
/// * [phoneNumber] 
@BuiltValue()
abstract class UpdateAgentRequest implements Built<UpdateAgentRequest, UpdateAgentRequestBuilder> {
  @BuiltValueField(wireName: r'businessName')
  String get businessName;

  @BuiltValueField(wireName: r'tier')
  UpdateAgentRequestTierEnum get tier;
  // enum tierEnum {  BASIC,  STANDARD,  PREMIUM,  };

  @BuiltValueField(wireName: r'merchantGpsLat')
  num get merchantGpsLat;

  @BuiltValueField(wireName: r'merchantGpsLng')
  num get merchantGpsLng;

  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  UpdateAgentRequest._();

  factory UpdateAgentRequest([void updates(UpdateAgentRequestBuilder b)]) = _$UpdateAgentRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAgentRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAgentRequest> get serializer => _$UpdateAgentRequestSerializer();
}

class _$UpdateAgentRequestSerializer implements PrimitiveSerializer<UpdateAgentRequest> {
  @override
  final Iterable<Type> types = const [UpdateAgentRequest, _$UpdateAgentRequest];

  @override
  final String wireName = r'UpdateAgentRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'businessName';
    yield serializers.serialize(
      object.businessName,
      specifiedType: const FullType(String),
    );
    yield r'tier';
    yield serializers.serialize(
      object.tier,
      specifiedType: const FullType(UpdateAgentRequestTierEnum),
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
    yield r'phoneNumber';
    yield serializers.serialize(
      object.phoneNumber,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAgentRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAgentRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
            specifiedType: const FullType(UpdateAgentRequestTierEnum),
          ) as UpdateAgentRequestTierEnum;
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
  UpdateAgentRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAgentRequestBuilder();
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

class UpdateAgentRequestTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'BASIC')
  static const UpdateAgentRequestTierEnum BASIC = _$updateAgentRequestTierEnum_BASIC;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const UpdateAgentRequestTierEnum STANDARD = _$updateAgentRequestTierEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIUM')
  static const UpdateAgentRequestTierEnum PREMIUM = _$updateAgentRequestTierEnum_PREMIUM;

  static Serializer<UpdateAgentRequestTierEnum> get serializer => _$updateAgentRequestTierEnumSerializer;

  const UpdateAgentRequestTierEnum._(String name): super(name);

  static BuiltSet<UpdateAgentRequestTierEnum> get values => _$updateAgentRequestTierEnumValues;
  static UpdateAgentRequestTierEnum valueOf(String name) => _$updateAgentRequestTierEnumValueOf(name);
}

