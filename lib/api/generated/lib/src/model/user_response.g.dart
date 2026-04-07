// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserResponseUserTypeEnum _$userResponseUserTypeEnum_INTERNAL =
    const UserResponseUserTypeEnum._('INTERNAL');
const UserResponseUserTypeEnum _$userResponseUserTypeEnum_EXTERNAL =
    const UserResponseUserTypeEnum._('EXTERNAL');

UserResponseUserTypeEnum _$userResponseUserTypeEnumValueOf(String name) {
  switch (name) {
    case 'INTERNAL':
      return _$userResponseUserTypeEnum_INTERNAL;
    case 'EXTERNAL':
      return _$userResponseUserTypeEnum_EXTERNAL;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserResponseUserTypeEnum> _$userResponseUserTypeEnumValues =
    BuiltSet<UserResponseUserTypeEnum>(const <UserResponseUserTypeEnum>[
  _$userResponseUserTypeEnum_INTERNAL,
  _$userResponseUserTypeEnum_EXTERNAL,
]);

Serializer<UserResponseUserTypeEnum> _$userResponseUserTypeEnumSerializer =
    _$UserResponseUserTypeEnumSerializer();

class _$UserResponseUserTypeEnumSerializer
    implements PrimitiveSerializer<UserResponseUserTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'INTERNAL': 'INTERNAL',
    'EXTERNAL': 'EXTERNAL',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'INTERNAL': 'INTERNAL',
    'EXTERNAL': 'EXTERNAL',
  };

  @override
  final Iterable<Type> types = const <Type>[UserResponseUserTypeEnum];
  @override
  final String wireName = 'UserResponseUserTypeEnum';

  @override
  Object serialize(Serializers serializers, UserResponseUserTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserResponseUserTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserResponseUserTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UserResponse extends UserResponse {
  @override
  final String? userId;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final String? status;
  @override
  final UserResponseUserTypeEnum? userType;
  @override
  final bool? mustChangePassword;

  factory _$UserResponse([void Function(UserResponseBuilder)? updates]) =>
      (UserResponseBuilder()..update(updates))._build();

  _$UserResponse._(
      {this.userId,
      this.username,
      this.email,
      this.fullName,
      this.status,
      this.userType,
      this.mustChangePassword})
      : super._();
  @override
  UserResponse rebuild(void Function(UserResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserResponseBuilder toBuilder() => UserResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UserResponse &&
        userId == other.userId &&
        username == other.username &&
        email == other.email &&
        fullName == other.fullName &&
        status == other.status &&
        userType == other.userType &&
        mustChangePassword == other.mustChangePassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, userType.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UserResponse')
          ..add('userId', userId)
          ..add('username', username)
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('status', status)
          ..add('userType', userType)
          ..add('mustChangePassword', mustChangePassword))
        .toString();
  }
}

class UserResponseBuilder
    implements Builder<UserResponse, UserResponseBuilder> {
  _$UserResponse? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  UserResponseUserTypeEnum? _userType;
  UserResponseUserTypeEnum? get userType => _$this._userType;
  set userType(UserResponseUserTypeEnum? userType) =>
      _$this._userType = userType;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  UserResponseBuilder() {
    UserResponse._defaults(this);
  }

  UserResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _username = $v.username;
      _email = $v.email;
      _fullName = $v.fullName;
      _status = $v.status;
      _userType = $v.userType;
      _mustChangePassword = $v.mustChangePassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UserResponse other) {
    _$v = other as _$UserResponse;
  }

  @override
  void update(void Function(UserResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UserResponse build() => _build();

  _$UserResponse _build() {
    final _$result = _$v ??
        _$UserResponse._(
          userId: userId,
          username: username,
          email: email,
          fullName: fullName,
          status: status,
          userType: userType,
          mustChangePassword: mustChangePassword,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
