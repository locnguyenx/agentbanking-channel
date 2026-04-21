//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'application_submit_request.g.dart';

/// ApplicationSubmitRequest
///
/// Properties:
/// * [agentCode] - Unique agent code
/// * [businessName] 
/// * [tier] 
/// * [mykadNumber] 
/// * [phoneNumber] 
/// * [merchantGpsLat] 
/// * [merchantGpsLng] 
/// * [email] 
/// * [address] 
@BuiltValue()
abstract class ApplicationSubmitRequest implements Built<ApplicationSubmitRequest, ApplicationSubmitRequestBuilder> {
  /// Unique agent code
  @BuiltValueField(wireName: r'agentCode')
  String get agentCode;

  @BuiltValueField(wireName: r'businessName')
  String get businessName;

  @BuiltValueField(wireName: r'tier')
  ApplicationSubmitRequestTierEnum get tier;
  // enum tierEnum {  MICRO,  STANDARD,  PREMIER,  };

  @BuiltValueField(wireName: r'mykadNumber')
  String get mykadNumber;

  @BuiltValueField(wireName: r'phoneNumber')
  String get phoneNumber;

  @BuiltValueField(wireName: r'merchantGpsLat')
  num get merchantGpsLat;

  @BuiltValueField(wireName: r'merchantGpsLng')
  num get merchantGpsLng;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'address')
  String? get address;

  ApplicationSubmitRequest._();

  factory ApplicationSubmitRequest([void updates(ApplicationSubmitRequestBuilder b)]) = _$ApplicationSubmitRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ApplicationSubmitRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ApplicationSubmitRequest> get serializer => _$ApplicationSubmitRequestSerializer();
}

class _$ApplicationSubmitRequestSerializer implements PrimitiveSerializer<ApplicationSubmitRequest> {
  @override
  final Iterable<Type> types = const [ApplicationSubmitRequest, _$ApplicationSubmitRequest];

  @override
  final String wireName = r'ApplicationSubmitRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ApplicationSubmitRequest object, {
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
      specifiedType: const FullType(ApplicationSubmitRequestTierEnum),
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
    ApplicationSubmitRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ApplicationSubmitRequestBuilder result,
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
            specifiedType: const FullType(ApplicationSubmitRequestTierEnum),
          ) as ApplicationSubmitRequestTierEnum;
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
  ApplicationSubmitRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ApplicationSubmitRequestBuilder();
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

class ApplicationSubmitRequestTierEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MICRO')
  static const ApplicationSubmitRequestTierEnum MICRO = _$applicationSubmitRequestTierEnum_MICRO;
  @BuiltValueEnumConst(wireName: r'STANDARD')
  static const ApplicationSubmitRequestTierEnum STANDARD = _$applicationSubmitRequestTierEnum_STANDARD;
  @BuiltValueEnumConst(wireName: r'PREMIER')
  static const ApplicationSubmitRequestTierEnum PREMIER = _$applicationSubmitRequestTierEnum_PREMIER;

  static Serializer<ApplicationSubmitRequestTierEnum> get serializer => _$applicationSubmitRequestTierEnumSerializer;

  const ApplicationSubmitRequestTierEnum._(String name): super(name);

  static BuiltSet<ApplicationSubmitRequestTierEnum> get values => _$applicationSubmitRequestTierEnumValues;
  static ApplicationSubmitRequestTierEnum valueOf(String name) => _$applicationSubmitRequestTierEnumValueOf(name);
}

