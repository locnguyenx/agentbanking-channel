// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maker_propose_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MakerProposeRequest extends MakerProposeRequest {
  @override
  final String? caseId;
  @override
  final String? action;
  @override
  final String? userId;
  @override
  final String? reason;

  factory _$MakerProposeRequest(
          [void Function(MakerProposeRequestBuilder)? updates]) =>
      (MakerProposeRequestBuilder()..update(updates))._build();

  _$MakerProposeRequest._({this.caseId, this.action, this.userId, this.reason})
      : super._();
  @override
  MakerProposeRequest rebuild(
          void Function(MakerProposeRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MakerProposeRequestBuilder toBuilder() =>
      MakerProposeRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MakerProposeRequest &&
        caseId == other.caseId &&
        action == other.action &&
        userId == other.userId &&
        reason == other.reason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MakerProposeRequest')
          ..add('caseId', caseId)
          ..add('action', action)
          ..add('userId', userId)
          ..add('reason', reason))
        .toString();
  }
}

class MakerProposeRequestBuilder
    implements Builder<MakerProposeRequest, MakerProposeRequestBuilder> {
  _$MakerProposeRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _action;
  String? get action => _$this._action;
  set action(String? action) => _$this._action = action;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  MakerProposeRequestBuilder() {
    MakerProposeRequest._defaults(this);
  }

  MakerProposeRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caseId = $v.caseId;
      _action = $v.action;
      _userId = $v.userId;
      _reason = $v.reason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MakerProposeRequest other) {
    _$v = other as _$MakerProposeRequest;
  }

  @override
  void update(void Function(MakerProposeRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MakerProposeRequest build() => _build();

  _$MakerProposeRequest _build() {
    final _$result = _$v ??
        _$MakerProposeRequest._(
          caseId: caseId,
          action: action,
          userId: userId,
          reason: reason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
