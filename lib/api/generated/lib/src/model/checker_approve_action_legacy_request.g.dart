// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_approve_action_legacy_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckerApproveActionLegacyRequest
    extends CheckerApproveActionLegacyRequest {
  @override
  final String caseId;
  @override
  final String userId;
  @override
  final String? reason;

  factory _$CheckerApproveActionLegacyRequest(
          [void Function(CheckerApproveActionLegacyRequestBuilder)? updates]) =>
      (CheckerApproveActionLegacyRequestBuilder()..update(updates))._build();

  _$CheckerApproveActionLegacyRequest._(
      {required this.caseId, required this.userId, this.reason})
      : super._();
  @override
  CheckerApproveActionLegacyRequest rebuild(
          void Function(CheckerApproveActionLegacyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckerApproveActionLegacyRequestBuilder toBuilder() =>
      CheckerApproveActionLegacyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckerApproveActionLegacyRequest &&
        caseId == other.caseId &&
        userId == other.userId &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CheckerApproveActionLegacyRequest')
          ..add('caseId', caseId)
          ..add('userId', userId)
          ..add('reason', reason))
        .toString();
  }
}

class CheckerApproveActionLegacyRequestBuilder
    implements
        Builder<CheckerApproveActionLegacyRequest,
            CheckerApproveActionLegacyRequestBuilder> {
  _$CheckerApproveActionLegacyRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CheckerApproveActionLegacyRequestBuilder() {
    CheckerApproveActionLegacyRequest._defaults(this);
  }

  CheckerApproveActionLegacyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caseId = $v.caseId;
      _userId = $v.userId;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CheckerApproveActionLegacyRequest other) {
    _$v = other as _$CheckerApproveActionLegacyRequest;
  }

  @override
  void update(
      void Function(CheckerApproveActionLegacyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckerApproveActionLegacyRequest build() => _build();

  _$CheckerApproveActionLegacyRequest _build() {
    final _$result = _$v ??
        _$CheckerApproveActionLegacyRequest._(
          caseId: BuiltValueNullFieldError.checkNotNull(
              caseId, r'CheckerApproveActionLegacyRequest', 'caseId'),
          userId: BuiltValueNullFieldError.checkNotNull(
              userId, r'CheckerApproveActionLegacyRequest', 'userId'),
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
