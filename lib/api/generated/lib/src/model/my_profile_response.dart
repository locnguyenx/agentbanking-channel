//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'my_profile_response.g.dart';

/// MyProfileResponse
///
/// Properties:
/// * [userId] 
/// * [username] 
/// * [email] 
/// * [fullName] 
/// * [userType] 
/// * [status] 
/// * [agentId] - The linked agent ID for external users
/// * [mustChangePassword] 
/// * [permissions] 
@BuiltValue()
abstract class MyProfileResponse implements Built<MyProfileResponse, MyProfileResponseBuilder> {
  @BuiltValueField(wireName: r'userId')
  String? get userId;

  @BuiltValueField(wireName: r'username')
  String? get username;

  @BuiltValueField(wireName: r'email')
  String? get email;

  @BuiltValueField(wireName: r'fullName')
  String? get fullName;

  @BuiltValueField(wireName: r'userType')
  MyProfileResponseUserTypeEnum? get userType;
  // enum userTypeEnum {  INTERNAL,  EXTERNAL,  };

  @BuiltValueField(wireName: r'status')
  String? get status;

  /// The linked agent ID for external users
  @BuiltValueField(wireName: r'agentId')
  String? get agentId;

  @BuiltValueField(wireName: r'mustChangePassword')
  bool? get mustChangePassword;

  @BuiltValueField(wireName: r'permissions')
  BuiltList<String>? get permissions;

  MyProfileResponse._();

  factory MyProfileResponse([void updates(MyProfileResponseBuilder b)]) = _$MyProfileResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MyProfileResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MyProfileResponse> get serializer => _$MyProfileResponseSerializer();
}

class _$MyProfileResponseSerializer implements PrimitiveSerializer<MyProfileResponse> {
  @override
  final Iterable<Type> types = const [MyProfileResponse, _$MyProfileResponse];

  @override
  final String wireName = r'MyProfileResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MyProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.userId != null) {
      yield r'userId';
      yield serializers.serialize(
        object.userId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.username != null) {
      yield r'username';
      yield serializers.serialize(
        object.username,
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
    if (object.fullName != null) {
      yield r'fullName';
      yield serializers.serialize(
        object.fullName,
        specifiedType: const FullType(String),
      );
    }
    if (object.userType != null) {
      yield r'userType';
      yield serializers.serialize(
        object.userType,
        specifiedType: const FullType(MyProfileResponseUserTypeEnum),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.agentId != null) {
      yield r'agentId';
      yield serializers.serialize(
        object.agentId,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.mustChangePassword != null) {
      yield r'mustChangePassword';
      yield serializers.serialize(
        object.mustChangePassword,
        specifiedType: const FullType(bool),
      );
    }
    if (object.permissions != null) {
      yield r'permissions';
      yield serializers.serialize(
        object.permissions,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MyProfileResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MyProfileResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'userId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.userId = valueDes;
          break;
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'fullName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fullName = valueDes;
          break;
        case r'userType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MyProfileResponseUserTypeEnum),
          ) as MyProfileResponseUserTypeEnum;
          result.userType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'agentId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.agentId = valueDes;
          break;
        case r'mustChangePassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.mustChangePassword = valueDes;
          break;
        case r'permissions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.permissions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MyProfileResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MyProfileResponseBuilder();
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

class MyProfileResponseUserTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'INTERNAL')
  static const MyProfileResponseUserTypeEnum INTERNAL = _$myProfileResponseUserTypeEnum_INTERNAL;
  @BuiltValueEnumConst(wireName: r'EXTERNAL')
  static const MyProfileResponseUserTypeEnum EXTERNAL = _$myProfileResponseUserTypeEnum_EXTERNAL;

  static Serializer<MyProfileResponseUserTypeEnum> get serializer => _$myProfileResponseUserTypeEnumSerializer;

  const MyProfileResponseUserTypeEnum._(String name): super(name);

  static BuiltSet<MyProfileResponseUserTypeEnum> get values => _$myProfileResponseUserTypeEnumValues;
  static MyProfileResponseUserTypeEnum valueOf(String name) => _$myProfileResponseUserTypeEnumValueOf(name);
}

