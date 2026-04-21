// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fee_config_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_ACTIVE =
    const FeeConfigResponseStatusEnum._('ACTIVE');
const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_INACTIVE =
    const FeeConfigResponseStatusEnum._('INACTIVE');
const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_SUSPENDED =
    const FeeConfigResponseStatusEnum._('SUSPENDED');
const FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnum_PENDING =
    const FeeConfigResponseStatusEnum._('PENDING');

FeeConfigResponseStatusEnum _$feeConfigResponseStatusEnumValueOf(String name) {
  switch (name) {
    case 'ACTIVE':
      return _$feeConfigResponseStatusEnum_ACTIVE;
    case 'INACTIVE':
      return _$feeConfigResponseStatusEnum_INACTIVE;
    case 'SUSPENDED':
      return _$feeConfigResponseStatusEnum_SUSPENDED;
    case 'PENDING':
      return _$feeConfigResponseStatusEnum_PENDING;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeeConfigResponseStatusEnum>
    _$feeConfigResponseStatusEnumValues =
    BuiltSet<FeeConfigResponseStatusEnum>(const <FeeConfigResponseStatusEnum>[
  _$feeConfigResponseStatusEnum_ACTIVE,
  _$feeConfigResponseStatusEnum_INACTIVE,
  _$feeConfigResponseStatusEnum_SUSPENDED,
  _$feeConfigResponseStatusEnum_PENDING,
]);

Serializer<FeeConfigResponseStatusEnum>
    _$feeConfigResponseStatusEnumSerializer =
    _$FeeConfigResponseStatusEnumSerializer();

class _$FeeConfigResponseStatusEnumSerializer
    implements PrimitiveSerializer<FeeConfigResponseStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'PENDING': 'PENDING',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ACTIVE': 'ACTIVE',
    'INACTIVE': 'INACTIVE',
    'SUSPENDED': 'SUSPENDED',
    'PENDING': 'PENDING',
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
  final String? agentTier;
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
  final String? createdAt;
  @override
  final String? updatedAt;

  factory _$FeeConfigResponse(
          [void Function(FeeConfigResponseBuilder)? updates]) =>
      (FeeConfigResponseBuilder()..update(updates))._build();

  _$FeeConfigResponse._(
      {this.feeConfigId,
      this.agentTier,
      this.transactionType,
      this.feeType,
      this.feeAmount,
      this.percentage,
      this.status,
      this.createdAt,
      this.updatedAt})
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
        agentTier == other.agentTier &&
        transactionType == other.transactionType &&
        feeType == other.feeType &&
        feeAmount == other.feeAmount &&
        percentage == other.percentage &&
        status == other.status &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feeConfigId.hashCode);
    _$hash = $jc(_$hash, agentTier.hashCode);
    _$hash = $jc(_$hash, transactionType.hashCode);
    _$hash = $jc(_$hash, feeType.hashCode);
    _$hash = $jc(_$hash, feeAmount.hashCode);
    _$hash = $jc(_$hash, percentage.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FeeConfigResponse')
          ..add('feeConfigId', feeConfigId)
          ..add('agentTier', agentTier)
          ..add('transactionType', transactionType)
          ..add('feeType', feeType)
          ..add('feeAmount', feeAmount)
          ..add('percentage', percentage)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class FeeConfigResponseBuilder
    implements Builder<FeeConfigResponse, FeeConfigResponseBuilder> {
  _$FeeConfigResponse? _$v;

  String? _feeConfigId;
  String? get feeConfigId => _$this._feeConfigId;
  set feeConfigId(String? feeConfigId) => _$this._feeConfigId = feeConfigId;

  String? _agentTier;
  String? get agentTier => _$this._agentTier;
  set agentTier(String? agentTier) => _$this._agentTier = agentTier;

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

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  FeeConfigResponseBuilder() {
    FeeConfigResponse._defaults(this);
  }

  FeeConfigResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feeConfigId = $v.feeConfigId;
      _agentTier = $v.agentTier;
      _transactionType = $v.transactionType;
      _feeType = $v.feeType;
      _feeAmount = $v.feeAmount;
      _percentage = $v.percentage;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
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
          agentTier: agentTier,
          transactionType: transactionType,
          feeType: feeType,
          feeAmount: feeAmount,
          percentage: percentage,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
