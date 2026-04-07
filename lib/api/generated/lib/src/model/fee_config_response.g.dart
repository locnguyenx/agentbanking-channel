// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_config_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_CREATED =
    const FeeConfigResponseStatusEnum._('CREATED');
const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_ACTIVE =
    const FeeConfigResponseStatusEnum._('ACTIVE');
const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_INACTIVE =
    const FeeConfigResponseStatusEnum._('INACTIVE');

FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'CREATED':
      return _$feeConfigResponseStatusEnum_CREATED;
    case 'ACTIVE':
      return _$feeConfigResponseStatusEnum_ACTIVE;
    case 'INACTIVE':
      return _$feeConfigResponseStatusEnum_INACTIVE;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigResponseStatusEnum>
    _$feeConfigResponseStatusEnumValues =
    BuiltSet<FeeConfigResponseStatusEnum>(const <FeeConfigResponseStatusEnum>[
  _$feeConfigResponseStatusEnum_CREATED,
  _$feeConfigResponseStatusEnum_ACTIVE,
  _$feeConfigResponseStatusEnum_INACTIVE,
]);

Serializer<FeeConfigResponseStatusEnum>
    _$feeConfigResponseStatusEnumSerializer =
    _$FeeConfigResponseStatusEnumSerializer();

class _$FeeConfigResponseStatusEnumSerializer
    implements PrimitiveSerializer<FeeConfigResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CREATED': 'CREATED',
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CREATED': 'CREATED',
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
  };

  @override
  final Iterable<Type> types = const <Type>[FeeConfigResponseStatusEnum];
  @override
  final String wireName = 'FeeConfigResponseStatusEnum';

  @override
  Object serialize(Serializers serializers, FeeConfigResponseStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeeConfigResponseStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeeConfigResponseStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FeeConfigResponse extends FeeConfigResponse {
  @override
  final String? feeConfigId;
  @override
  final String? agentType;
  @override
  final String? transactionType;
  @override
  final String? feeType;
  @override
  final String? feeAmount;
  @override
  final String? percentage;
  @override
  final FeeConfigResponseStatusEnum? status;
  @override
  final DateTime? effectiveFrom;
  @override
  final DateTime? effectiveTo;

  factory _$FeeConfigResponse(
          [void Function(FeeConfigResponseBuilder)? updates]) =>
      (FeeConfigResponseBuilder()..update(updates))._build();

  _$FeeConfigResponse._(
      {this.feeConfigId,
      this.agentType,
      this.transactionType,
      this.feeType,
      this.feeAmount,
      this.percentage,
      this.status,
      this.effectiveFrom,
      this.effectiveTo})
      : super._();
  @override
  FeeConfigResponse rebuild(void Function(FeeConfigResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FeeConfigResponseBuilder toBuilder() =>
      FeeConfigResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FeeConfigResponse &&
        feeConfigId == other.feeConfigId &&
        agentType == other.agentType &&
        transactionType == other.transactionType &&
        feeType == other.feeType &&
        feeAmount == other.feeAmount &&
        percentage == other.percentage &&
        status == other.status &&
        effectiveFrom == other.effectiveFrom &&
        effectiveTo == other.effectiveTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feeConfigId.hashCode);
    _$hash = $jc(_$hash, agentType.hashCode);
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, feeType.hashCode);
    _$hash = $jc(_$hash, feeAmount.hashCode);
    _$hash = $jc(_$hash, percentage.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, effectiveFrom.hashCode);
    _$hash = $jc(_$hash, effectiveTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeeConfigResponse')
          ..add('feeConfigId', feeConfigId)
          ..add('agentType', agentType)
          ..add('transactionType', transactionType)
          ..add('feeType', feeType)
          ..add('feeAmount', feeAmount)
          ..add('percentage', percentage)
          ..add('status', status)
          ..add('effectiveFrom', effectiveFrom)
          ..add('effectiveTo', effectiveTo))
        .toString();
  }
}

class FeeConfigResponseBuilder
    implements Builder<FeeConfigResponse, FeeConfigResponseBuilder> {
  _$FeeConfigResponse? _$v;

  String? _feeConfigId;
  String? get feeConfigId => _$this._feeConfigId;
  set feeConfigId(String? feeConfigId) => _$this._feeConfigId = feeConfigId;

  String? _agentType;
  String? get agentType => _$this._agentType;
  set agentType(String? agentType) => _$this._agentType = agentType;

  String? _transactionType;
  String? get transactionType => _$this._transactionType;
  set transactionType(String? transactionType) =>
      _$this._transactionType = transactionType;

  String? _feeType;
  String? get feeType => _$this._feeType;
  set feeType(String? feeType) => _$this._feeType = feeType;

  String? _feeAmount;
  String? get feeAmount => _$this._feeAmount;
  set feeAmount(String? feeAmount) => _$this._feeAmount = feeAmount;

  String? _percentage;
  String? get percentage => _$this._percentage;
  set percentage(String? percentage) => _$this._percentage = percentage;

  FeeConfigResponseStatusEnum? _status;
  FeeConfigResponseStatusEnum? get status => _$this._status;
  set status(FeeConfigResponseStatusEnum? status) => _$this._status = status;

  DateTime? _effectiveFrom;
  DateTime? get effectiveFrom => _$this._effectiveFrom;
  set effectiveFrom(DateTime? effectiveFrom) =>
      _$this._effectiveFrom = effectiveFrom;

  DateTime? _effectiveTo;
  DateTime? get effectiveTo => _$this._effectiveTo;
  set effectiveTo(DateTime? effectiveTo) => _$this._effectiveTo = effectiveTo;

  FeeConfigResponseBuilder() {
    FeeConfigResponse._defaults(this);
  }

  FeeConfigResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feeConfigId = $v.feeConfigId;
      _agentType = $v.agentType;
      _transactionType = $v.transactionType;
      _feeType = $v.feeType;
      _feeAmount = $v.feeAmount;
      _percentage = $v.percentage;
      _status = $v.status;
      _effectiveFrom = $v.effectiveFrom;
      _effectiveTo = $v.effectiveTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FeeConfigResponse other) {
    _$v = other as _$FeeConfigResponse;
  }

  @override
  void update(void Function(FeeConfigResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FeeConfigResponse build() => _build();

  _$FeeConfigResponse _build() {
    final _$result = _$v ??
        _$FeeConfigResponse._(
          feeConfigId: feeConfigId,
          agentType: agentType,
          transactionType: transactionType,
          feeType: feeType,
          feeAmount: feeAmount,
          percentage: percentage,
          status: status,
          effectiveFrom: effectiveFrom,
          effectiveTo: effectiveTo,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
