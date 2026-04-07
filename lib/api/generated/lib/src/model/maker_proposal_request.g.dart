// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'maker_proposal_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MakerProposalRequestActionEnum _$makerProposalRequestActionEnum_COMMIT =
    const MakerProposalRequestActionEnum._('COMMIT');
const MakerProposalRequestActionEnum _$makerProposalRequestActionEnum_ROLLBACK =
    const MakerProposalRequestActionEnum._('ROLLBACK');
const MakerProposalRequestActionEnum _$makerProposalRequestActionEnum_ESCALATE =
    const MakerProposalRequestActionEnum._('ESCALATE');

MakerProposalRequestActionEnum _$makerProposalRequestActionEnumValueOf(
    String name) {
  switch (name) {
    case 'COMMIT':
      return _$makerProposalRequestActionEnum_COMMIT;
    case 'ROLLBACK':
      return _$makerProposalRequestActionEnum_ROLLBACK;
    case 'ESCALATE':
      return _$makerProposalRequestActionEnum_ESCALATE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MakerProposalRequestActionEnum>
    _$makerProposalRequestActionEnumValues = BuiltSet<
        MakerProposalRequestActionEnum>(const <MakerProposalRequestActionEnum>[
  _$makerProposalRequestActionEnum_COMMIT,
  _$makerProposalRequestActionEnum_ROLLBACK,
  _$makerProposalRequestActionEnum_ESCALATE,
]);

Serializer<MakerProposalRequestActionEnum>
    _$makerProposalRequestActionEnumSerializer =
    _$MakerProposalRequestActionEnumSerializer();

class _$MakerProposalRequestActionEnumSerializer
    implements PrimitiveSerializer<MakerProposalRequestActionEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'COMMIT': 'COMMIT',
    'ROLLBACK': 'ROLLBACK',
    'ESCALATE': 'ESCALATE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'COMMIT': 'COMMIT',
    'ROLLBACK': 'ROLLBACK',
    'ESCALATE': 'ESCALATE',
  };

  @override
  final Iterable<Type> types = const <Type>[MakerProposalRequestActionEnum];
  @override
  final String wireName = 'MakerProposalRequestActionEnum';

  @override
  Object serialize(
          Serializers serializers, MakerProposalRequestActionEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MakerProposalRequestActionEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MakerProposalRequestActionEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$MakerProposalRequest extends MakerProposalRequest {
  @override
  final MakerProposalRequestActionEnum action;
  @override
  final String? reasonCode;
  @override
  final String? reason;
  @override
  final String? evidenceUrl;

  factory _$MakerProposalRequest(
          [void Function(MakerProposalRequestBuilder)? updates]) =>
      (MakerProposalRequestBuilder()..update(updates))._build();

  _$MakerProposalRequest._(
      {required this.action, this.reasonCode, this.reason, this.evidenceUrl})
      : super._();
  @override
  MakerProposalRequest rebuild(
          void Function(MakerProposalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MakerProposalRequestBuilder toBuilder() =>
      MakerProposalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MakerProposalRequest &&
        action == other.action &&
        reasonCode == other.reasonCode &&
        reason == other.reason &&
        evidenceUrl == other.evidenceUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, action.hashCode);
    _$hash = $jc(_$hash, reasonCode.hashCode);
    _$hash = $jc(_$hash, reason.hashCode);
    _$hash = $jc(_$hash, evidenceUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MakerProposalRequest')
          ..add('action', action)
          ..add('reasonCode', reasonCode)
          ..add('reason', reason)
          ..add('evidenceUrl', evidenceUrl))
        .toString();
  }
}

class MakerProposalRequestBuilder
    implements Builder<MakerProposalRequest, MakerProposalRequestBuilder> {
  _$MakerProposalRequest? _$v;

  MakerProposalRequestActionEnum? _action;
  MakerProposalRequestActionEnum? get action => _$this._action;
  set action(MakerProposalRequestActionEnum? action) => _$this._action = action;

  String? _reasonCode;
  String? get reasonCode => _$this._reasonCode;
  set reasonCode(String? reasonCode) => _$this._reasonCode = reasonCode;

  String? _reason;
  String? get reason => _$this._reason;
  set reason(String? reason) => _$this._reason = reason;

  String? _evidenceUrl;
  String? get evidenceUrl => _$this._evidenceUrl;
  set evidenceUrl(String? evidenceUrl) => _$this._evidenceUrl = evidenceUrl;

  MakerProposalRequestBuilder() {
    MakerProposalRequest._defaults(this);
  }

  MakerProposalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _action = $v.action;
      _reasonCode = $v.reasonCode;
      _reason = $v.reason;
      _evidenceUrl = $v.evidenceUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MakerProposalRequest other) {
    _$v = other as _$MakerProposalRequest;
  }

  @override
  void update(void Function(MakerProposalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MakerProposalRequest build() => _build();

  _$MakerProposalRequest _build() {
    final _$result = _$v ??
        _$MakerProposalRequest._(
          action: BuiltValueNullFieldError.checkNotNull(
              action, r'MakerProposalRequest', 'action'),
          reasonCode: reasonCode,
          reason: reason,
          evidenceUrl: evidenceUrl,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
