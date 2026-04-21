// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checker_approve_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CheckerApproveRequest extends CheckerApproveRequest {
  @override
  final String? caseId;
  @override
  final String? userId;
  @override
  final String? reason;

  factory _$CheckerApproveRequest(
          [void Function(CheckerApproveRequestBuilder)? updates]) =>
      (CheckerApproveRequestBuilder()..update(updates))._build();

  _$CheckerApproveRequest._({this.caseId, this.userId, this.reason})
      : super._();
  @override
  CheckerApproveRequest rebuild(
          void Function(CheckerApproveRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CheckerApproveRequestBuilder toBuilder() =>
      CheckerApproveRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CheckerApproveRequest &&
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
    return (newBuiltValueToStringHelper(r'CheckerApproveRequest')
          ..add('caseId', caseId)
          ..add('userId', userId)
          ..add('reason', reason))
        .toString();
  }
}

class CheckerApproveRequestBuilder
    implements Builder<CheckerApproveRequest, CheckerApproveRequestBuilder> {
  _$CheckerApproveRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  CheckerApproveRequestBuilder() {
    CheckerApproveRequest._defaults(this);
  }

  CheckerApproveRequestBuilder get _$this {
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
  void replace(CheckerApproveRequest other) {
    _$v = other as _$CheckerApproveRequest;
  }

  @override
  void update(void Function(CheckerApproveRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CheckerApproveRequest build() => _build();

  _$CheckerApproveRequest _build() {
    final _$result = _$v ??
        _$CheckerApproveRequest._(
          caseId: caseId,
          userId: userId,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
