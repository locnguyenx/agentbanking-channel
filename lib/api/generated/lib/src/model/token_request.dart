//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'token_request.g.dart';

/// TokenRequest
///
/// Properties:
/// * [username] 
/// * [password] 
/// * [grantType] 
@BuiltValue()
abstract class TokenRequest implements Built<TokenRequest, TokenRequestBuilder> {
  @BuiltValueField(wireName: r'username')
  String get username;

  @BuiltValueField(wireName: r'password')
  String get password;

  @BuiltValueField(wireName: r'grantType')
  TokenRequestGrantTypeEnum? get grantType;
  // enum grantTypeEnum {  password,  refresh_token,  };

  TokenRequest._();

  factory TokenRequest([void updates(TokenRequestBuilder b)]) = _$TokenRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TokenRequestBuilder b) => b
      ..grantType = TokenRequestGrantTypeEnum.valueOf('password');

  @BuiltValueSerializer(custom: true)
  static Serializer<TokenRequest> get serializer => _$TokenRequestSerializer();
}

class _$TokenRequestSerializer implements PrimitiveSerializer<TokenRequest> {
  @override
  final Iterable<Type> types = const [TokenRequest, _$TokenRequest];

  @override
  final String wireName = r'TokenRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'username';
    yield serializers.serialize(
      object.username,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    if (object.grantType != null) {
      yield r'grantType';
      yield serializers.serialize(
        object.grantType,
        specifiedType: const FullType(TokenRequestGrantTypeEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TokenRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TokenRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.username = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'grantType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TokenRequestGrantTypeEnum),
          ) as TokenRequestGrantTypeEnum;
          result.grantType = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TokenRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TokenRequestBuilder();
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

class TokenRequestGrantTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'password')
  static const TokenRequestGrantTypeEnum password = _$tokenRequestGrantTypeEnum_password;
  @BuiltValueEnumConst(wireName: r'refresh_token')
  static const TokenRequestGrantTypeEnum refreshToken = _$tokenRequestGrantTypeEnum_refreshToken;

  static Serializer<TokenRequestGrantTypeEnum> get serializer => _$tokenRequestGrantTypeEnumSerializer;

  const TokenRequestGrantTypeEnum._(String name): super(name);

  static BuiltSet<TokenRequestGrantTypeEnum> get values => _$tokenRequestGrantTypeEnumValues;
  static TokenRequestGrantTypeEnum valueOf(String name) => _$tokenRequestGrantTypeEnumValueOf(name);
}

