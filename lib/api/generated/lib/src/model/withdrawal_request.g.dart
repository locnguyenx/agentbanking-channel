// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdrawal_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WithdrawalRequest extends WithdrawalRequest {
  @override
  final String? agentId;
  @override
  final num? amount;
  @override
  final num? customerFee;
  @override
  final num? agentCommission;
  @override
  final num? bankShare;
  @override
  final String? idempotencyKey;
  @override
  final String? customerCardMasked;
  @override
  final num? geofenceLat;
  @override
  final num? geofenceLng;

  factory _$WithdrawalRequest(
          [void Function(WithdrawalRequestBuilder)? updates]) =>
      (WithdrawalRequestBuilder()..update(updates))._build();

  _$WithdrawalRequest._(
      {this.agentId,
      this.amount,
      this.customerFee,
      this.agentCommission,
      this.bankShare,
      this.idempotencyKey,
      this.customerCardMasked,
      this.geofenceLat,
      this.geofenceLng})
      : super._();
  @override
  WithdrawalRequest rebuild(void Function(WithdrawalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WithdrawalRequestBuilder toBuilder() =>
      WithdrawalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WithdrawalRequest &&
        agentId == other.agentId &&
        amount == other.amount &&
        customerFee == other.customerFee &&
        agentCommission == other.agentCommission &&
        bankShare == other.bankShare &&
        idempotencyKey == other.idempotencyKey &&
        customerCardMasked == other.customerCardMasked &&
        geofenceLat == other.geofenceLat &&
        geofenceLng == other.geofenceLng;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, customerFee.hashCode);
    _$hash = $jc(_$hash, agentCommission.hashCode);
    _$hash = $jc(_$hash, bankShare.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerCardMasked.hashCode);
    _$hash = $jc(_$hash, geofenceLat.hashCode);
    _$hash = $jc(_$hash, geofenceLng.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'WithdrawalRequest')
          ..add('agentId', agentId)
          ..add('amount', amount)
          ..add('customerFee', customerFee)
          ..add('agentCommission', agentCommission)
          ..add('bankShare', bankShare)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerCardMasked', customerCardMasked)
          ..add('geofenceLat', geofenceLat)
          ..add('geofenceLng', geofenceLng))
        .toString();
  }
}

class WithdrawalRequestBuilder
    implements Builder<WithdrawalRequest, WithdrawalRequestBuilder> {
  _$WithdrawalRequest? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

  num? _customerFee;
  num? get customerFee => _$this._customerFee;
  set customerFee(num? customerFee) => _$this._customerFee = customerFee;

  num? _agentCommission;
  num? get agentCommission => _$this._agentCommission;
  set agentCommission(num? agentCommission) =>
      _$this._agentCommission = agentCommission;

  num? _bankShare;
  num? get bankShare => _$this._bankShare;
  set bankShare(num? bankShare) => _$this._bankShare = bankShare;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _customerCardMasked;
  String? get customerCardMasked => _$this._customerCardMasked;
  set customerCardMasked(String? customerCardMasked) =>
      _$this._customerCardMasked = customerCardMasked;

  num? _geofenceLat;
  num? get geofenceLat => _$this._geofenceLat;
  set geofenceLat(num? geofenceLat) => _$this._geofenceLat = geofenceLat;

  num? _geofenceLng;
  num? get geofenceLng => _$this._geofenceLng;
  set geofenceLng(num? geofenceLng) => _$this._geofenceLng = geofenceLng;

  WithdrawalRequestBuilder() {
    WithdrawalRequest._defaults(this);
  }

  WithdrawalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _amount = $v.amount;
      _customerFee = $v.customerFee;
      _agentCommission = $v.agentCommission;
      _bankShare = $v.bankShare;
      _idempotencyKey = $v.idempotencyKey;
      _customerCardMasked = $v.customerCardMasked;
      _geofenceLat = $v.geofenceLat;
      _geofenceLng = $v.geofenceLng;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WithdrawalRequest other) {
    _$v = other as _$WithdrawalRequest;
  }

  @override
  void update(void Function(WithdrawalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  WithdrawalRequest build() => _build();

  _$WithdrawalRequest _build() {
    final _$result = _$v ??
        _$WithdrawalRequest._(
          agentId: agentId,
          amount: amount,
          customerFee: customerFee,
          agentCommission: agentCommission,
          bankShare: bankShare,
          idempotencyKey: idempotencyKey,
          customerCardMasked: customerCardMasked,
          geofenceLat: geofenceLat,
          geofenceLng: geofenceLng,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
