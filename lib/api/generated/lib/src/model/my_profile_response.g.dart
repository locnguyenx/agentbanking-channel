// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_profile_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MyProfileResponseUserTypeEnum _$myProfileResponseUserTypeEnum_INTERNAL =
    const MyProfileResponseUserTypeEnum._('INTERNAL');
const MyProfileResponseUserTypeEnum _$myProfileResponseUserTypeEnum_EXTERNAL =
    const MyProfileResponseUserTypeEnum._('EXTERNAL');

MyProfileResponseUserTypeEnum _$myProfileResponseUserTypeEnumValueOf(
    String name) {
  switch (name) {
    case 'INTERNAL':
      return _$myProfileResponseUserTypeEnum_INTERNAL;
    case 'EXTERNAL':
      return _$myProfileResponseUserTypeEnum_EXTERNAL;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MyProfileResponseUserTypeEnum>
    _$myProfileResponseUserTypeEnumValues = BuiltSet<
        MyProfileResponseUserTypeEnum>(const <MyProfileResponseUserTypeEnum>[
  _$myProfileResponseUserTypeEnum_INTERNAL,
  _$myProfileResponseUserTypeEnum_EXTERNAL,
]);

Serializer<MyProfileResponseUserTypeEnum>
    _$myProfileResponseUserTypeEnumSerializer =
    _$MyProfileResponseUserTypeEnumSerializer();

class _$MyProfileResponseUserTypeEnumSerializer
    implements PrimitiveSerializer<MyProfileResponseUserTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'INTERNAL': 'INTERNAL',
    'EXTERNAL': 'EXTERNAL',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'INTERNAL': 'INTERNAL',
    'EXTERNAL': 'EXTERNAL',
  };

  @override
  final Iterable<Type> types = const <Type>[MyProfileResponseUserTypeEnum];
  @override
  final String wireName = 'MyProfileResponseUserTypeEnum';

  @override
  Object serialize(
          Serializers serializers, MyProfileResponseUserTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MyProfileResponseUserTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MyProfileResponseUserTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MyProfileResponse extends MyProfileResponse {
  @override
  final String? userId;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final MyProfileResponseUserTypeEnum? userType;
  @override
  final String? status;
  @override
  final String? agentId;
  @override
  final bool? mustChangePassword;
  @override
  final BuiltList<String>? permissions;

  factory _$MyProfileResponse(
          [void Function(MyProfileResponseBuilder)? updates]) =>
      (MyProfileResponseBuilder()..update(updates))._build();

  _$MyProfileResponse._(
      {this.userId,
      this.username,
      this.email,
      this.fullName,
      this.userType,
      this.status,
      this.agentId,
      this.mustChangePassword,
      this.permissions})
      : super._();
  @override
  MyProfileResponse rebuild(void Function(MyProfileResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyProfileResponseBuilder toBuilder() =>
      MyProfileResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyProfileResponse &&
        userId == other.userId &&
        username == other.username &&
        email == other.email &&
        fullName == other.fullName &&
        userType == other.userType &&
        status == other.status &&
        agentId == other.agentId &&
        mustChangePassword == other.mustChangePassword &&
        permissions == other.permissions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, userType.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, mustChangePassword.hashCode);
    _$hash = $jc(_$hash, permissions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyProfileResponse')
          ..add('userId', userId)
          ..add('username', username)
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('userType', userType)
          ..add('status', status)
          ..add('agentId', agentId)
          ..add('mustChangePassword', mustChangePassword)
          ..add('permissions', permissions))
        .toString();
  }
}

class MyProfileResponseBuilder
    implements Builder<MyProfileResponse, MyProfileResponseBuilder> {
  _$MyProfileResponse? _$v;

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

  MyProfileResponseUserTypeEnum? _userType;
  MyProfileResponseUserTypeEnum? get userType => _$this._userType;
  set userType(MyProfileResponseUserTypeEnum? userType) =>
      _$this._userType = userType;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  bool? _mustChangePassword;
  bool? get mustChangePassword => _$this._mustChangePassword;
  set mustChangePassword(bool? mustChangePassword) =>
      _$this._mustChangePassword = mustChangePassword;

  ListBuilder<String>? _permissions;
  ListBuilder<String> get permissions =>
      _$this._permissions ??= ListBuilder<String>();
  set permissions(ListBuilder<String>? permissions) =>
      _$this._permissions = permissions;

  MyProfileResponseBuilder() {
    MyProfileResponse._defaults(this);
  }

  MyProfileResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _username = $v.username;
      _email = $v.email;
      _fullName = $v.fullName;
      _userType = $v.userType;
      _status = $v.status;
      _agentId = $v.agentId;
      _mustChangePassword = $v.mustChangePassword;
      _permissions = $v.permissions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyProfileResponse other) {
    _$v = other as _$MyProfileResponse;
  }

  @override
  void update(void Function(MyProfileResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyProfileResponse build() => _build();

  _$MyProfileResponse _build() {
    _$MyProfileResponse _$result;
    try {
      _$result = _$v ??
          _$MyProfileResponse._(
            userId: userId,
            username: username,
            email: email,
            fullName: fullName,
            userType: userType,
            status: status,
            agentId: agentId,
            mustChangePassword: mustChangePassword,
            permissions: _permissions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'permissions';
        _permissions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MyProfileResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
