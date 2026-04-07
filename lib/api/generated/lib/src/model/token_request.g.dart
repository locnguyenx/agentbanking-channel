// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnum_password =
    const TokenRequestGrantTypeEnum._('password');
const TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnum_refreshToken =
    const TokenRequestGrantTypeEnum._('refreshToken');

TokenRequestGrantTypeEnum _$tokenRequestGrantTypeEnumValueOf(String name) {
  switch (name) {
    case 'password':
      return _$tokenRequestGrantTypeEnum_password;
    case 'refreshToken':
      return _$tokenRequestGrantTypeEnum_refreshToken;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TokenRequestGrantTypeEnum> _$tokenRequestGrantTypeEnumValues =
    BuiltSet<TokenRequestGrantTypeEnum>(const <TokenRequestGrantTypeEnum>[
  _$tokenRequestGrantTypeEnum_password,
  _$tokenRequestGrantTypeEnum_refreshToken,
]);

Serializer<TokenRequestGrantTypeEnum> _$tokenRequestGrantTypeEnumSerializer =
    _$TokenRequestGrantTypeEnumSerializer();

class _$TokenRequestGrantTypeEnumSerializer
    implements PrimitiveSerializer<TokenRequestGrantTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'password': 'password',
    'refreshToken': 'refresh_token',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'password': 'password',
    'refresh_token': 'refreshToken',
  };

  @override
  final Iterable<Type> types = const <Type>[TokenRequestGrantTypeEnum];
  @override
  final String wireName = 'TokenRequestGrantTypeEnum';

  @override
  Object serialize(Serializers serializers, TokenRequestGrantTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TokenRequestGrantTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TokenRequestGrantTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TokenRequest extends TokenRequest {
  @override
  final String username;
  @override
  final String password;
  @override
  final TokenRequestGrantTypeEnum? grantType;

  factory _$TokenRequest([void Function(TokenRequestBuilder)? updates]) =>
      (TokenRequestBuilder()..update(updates))._build();

  _$TokenRequest._(
      {required this.username, required this.password, this.grantType})
      : super._();
  @override
  TokenRequest rebuild(void Function(TokenRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TokenRequestBuilder toBuilder() => TokenRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TokenRequest &&
        username == other.username &&
        password == other.password &&
        grantType == other.grantType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, grantType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TokenRequest')
          ..add('username', username)
          ..add('password', password)
          ..add('grantType', grantType))
        .toString();
  }
}

class TokenRequestBuilder
    implements Builder<TokenRequest, TokenRequestBuilder> {
  _$TokenRequest? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  TokenRequestGrantTypeEnum? _grantType;
  TokenRequestGrantTypeEnum? get grantType => _$this._grantType;
  set grantType(TokenRequestGrantTypeEnum? grantType) =>
      _$this._grantType = grantType;

  TokenRequestBuilder() {
    TokenRequest._defaults(this);
  }

  TokenRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _password = $v.password;
      _grantType = $v.grantType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TokenRequest other) {
    _$v = other as _$TokenRequest;
  }

  @override
  void update(void Function(TokenRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TokenRequest build() => _build();

  _$TokenRequest _build() {
    final _$result = _$v ??
        _$TokenRequest._(
          username: BuiltValueNullFieldError.checkNotNull(
              username, r'TokenRequest', 'username'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'TokenRequest', 'password'),
          grantType: grantType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
