// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_agent_user_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAgentUserRequest extends CreateAgentUserRequest {
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? fullName;

  factory _$CreateAgentUserRequest(
          [void Function(CreateAgentUserRequestBuilder)? updates]) =>
      (CreateAgentUserRequestBuilder()..update(updates))._build();

  _$CreateAgentUserRequest._({this.username, this.email, this.fullName})
      : super._();
  @override
  CreateAgentUserRequest rebuild(
          void Function(CreateAgentUserRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAgentUserRequestBuilder toBuilder() =>
      CreateAgentUserRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAgentUserRequest &&
        username == other.username &&
        email == other.email &&
        fullName == other.fullName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, username.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAgentUserRequest')
          ..add('username', username)
          ..add('email', email)
          ..add('fullName', fullName))
        .toString();
  }
}

class CreateAgentUserRequestBuilder
    implements Builder<CreateAgentUserRequest, CreateAgentUserRequestBuilder> {
  _$CreateAgentUserRequest? _$v;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  CreateAgentUserRequestBuilder() {
    CreateAgentUserRequest._defaults(this);
  }

  CreateAgentUserRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _username = $v.username;
      _email = $v.email;
      _fullName = $v.fullName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAgentUserRequest other) {
    _$v = other as _$CreateAgentUserRequest;
  }

  @override
  void update(void Function(CreateAgentUserRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAgentUserRequest build() => _build();

  _$CreateAgentUserRequest _build() {
    final _$result = _$v ??
        _$CreateAgentUserRequest._(
          username: username,
          email: email,
          fullName: fullName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
