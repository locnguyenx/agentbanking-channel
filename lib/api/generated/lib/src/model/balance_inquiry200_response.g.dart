// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_inquiry200_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$BalanceInquiry200Response extends BalanceInquiry200Response {
  @override
  final String? status;
  @override
  final num? balance;
  @override
  final String? currency;
  @override
  final String? accountMasked;
  @override
  final String? responseCode;

  factory _$BalanceInquiry200Response(
          [void Function(BalanceInquiry200ResponseBuilder)? updates]) =>
      (BalanceInquiry200ResponseBuilder()..update(updates))._build();

  _$BalanceInquiry200Response._(
      {this.status,
      this.balance,
      this.currency,
      this.accountMasked,
      this.responseCode})
      : super._();
  @override
  BalanceInquiry200Response rebuild(
          void Function(BalanceInquiry200ResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BalanceInquiry200ResponseBuilder toBuilder() =>
      BalanceInquiry200ResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BalanceInquiry200Response &&
        status == other.status &&
        balance == other.balance &&
        currency == other.currency &&
        accountMasked == other.accountMasked &&
        responseCode == other.responseCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, balance.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, accountMasked.hashCode);
    _$hash = $jc(_$hash, responseCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BalanceInquiry200Response')
          ..add('status', status)
          ..add('balance', balance)
          ..add('currency', currency)
          ..add('accountMasked', accountMasked)
          ..add('responseCode', responseCode))
        .toString();
  }
}

class BalanceInquiry200ResponseBuilder
    implements
        Builder<BalanceInquiry200Response, BalanceInquiry200ResponseBuilder> {
  _$BalanceInquiry200Response? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  num? _balance;
  num? get balance => _$this._balance;
  set balance(num? balance) => _$this._balance = balance;

  String? _currency;
  String? get currency => _$this._currency;
  set currency(String? currency) => _$this._currency = currency;

  String? _accountMasked;
  String? get accountMasked => _$this._accountMasked;
  set accountMasked(String? accountMasked) =>
      _$this._accountMasked = accountMasked;

  String? _responseCode;
  String? get responseCode => _$this._responseCode;
  set responseCode(String? responseCode) => _$this._responseCode = responseCode;

  BalanceInquiry200ResponseBuilder() {
    BalanceInquiry200Response._defaults(this);
  }

  BalanceInquiry200ResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _balance = $v.balance;
      _currency = $v.currency;
      _accountMasked = $v.accountMasked;
      _responseCode = $v.responseCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BalanceInquiry200Response other) {
    _$v = other as _$BalanceInquiry200Response;
  }

  @override
  void update(void Function(BalanceInquiry200ResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BalanceInquiry200Response build() => _build();

  _$BalanceInquiry200Response _build() {
    final _$result = _$v ??
        _$BalanceInquiry200Response._(
          status: status,
          balance: balance,
          currency: currency,
          accountMasked: accountMasked,
          responseCode: responseCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
