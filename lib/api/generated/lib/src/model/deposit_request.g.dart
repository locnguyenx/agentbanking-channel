// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositRequest extends DepositRequest {
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
  final String? destinationAccount;

  factory _$DepositRequest([void Function(DepositRequestBuilder)? updates]) =>
      (DepositRequestBuilder()..update(updates))._build();

  _$DepositRequest._(
      {this.agentId,
      this.amount,
      this.customerFee,
      this.agentCommission,
      this.bankShare,
      this.idempotencyKey,
      this.destinationAccount})
      : super._();
  @override
  DepositRequest rebuild(void Function(DepositRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositRequestBuilder toBuilder() => DepositRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositRequest &&
        agentId == other.agentId &&
        amount == other.amount &&
        customerFee == other.customerFee &&
        agentCommission == other.agentCommission &&
        bankShare == other.bankShare &&
        idempotencyKey == other.idempotencyKey &&
        destinationAccount == other.destinationAccount;
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
    _$hash = $jc(_$hash, destinationAccount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositRequest')
          ..add('agentId', agentId)
          ..add('amount', amount)
          ..add('customerFee', customerFee)
          ..add('agentCommission', agentCommission)
          ..add('bankShare', bankShare)
          ..add('idempotencyKey', idempotencyKey)
          ..add('destinationAccount', destinationAccount))
        .toString();
  }
}

class DepositRequestBuilder
    implements Builder<DepositRequest, DepositRequestBuilder> {
  _$DepositRequest? _$v;

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

  String? _destinationAccount;
  String? get destinationAccount => _$this._destinationAccount;
  set destinationAccount(String? destinationAccount) =>
      _$this._destinationAccount = destinationAccount;

  DepositRequestBuilder() {
    DepositRequest._defaults(this);
  }

  DepositRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _amount = $v.amount;
      _customerFee = $v.customerFee;
      _agentCommission = $v.agentCommission;
      _bankShare = $v.bankShare;
      _idempotencyKey = $v.idempotencyKey;
      _destinationAccount = $v.destinationAccount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositRequest other) {
    _$v = other as _$DepositRequest;
  }

  @override
  void update(void Function(DepositRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositRequest build() => _build();

  _$DepositRequest _build() {
    final _$result = _$v ??
        _$DepositRequest._(
          agentId: agentId,
          amount: amount,
          customerFee: customerFee,
          agentCommission: agentCommission,
          bankShare: bankShare,
          idempotencyKey: idempotencyKey,
          destinationAccount: destinationAccount,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
