// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_auth_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CardAuthRequest extends CardAuthRequest {
  @override
  final String internalTransactionId;
  @override
  final String pan;
  @override
  final String amount;

  factory _$CardAuthRequest([void Function(CardAuthRequestBuilder)? updates]) =>
      (CardAuthRequestBuilder()..update(updates))._build();

  _$CardAuthRequest._(
      {required this.internalTransactionId,
      required this.pan,
      required this.amount})
      : super._();
  @override
  CardAuthRequest rebuild(void Function(CardAuthRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CardAuthRequestBuilder toBuilder() => CardAuthRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CardAuthRequest &&
        internalTransactionId == other.internalTransactionId &&
        pan == other.pan &&
        amount == other.amount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, internalTransactionId.hashCode);
    _$hash = $jc(_$hash, pan.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CardAuthRequest')
          ..add('internalTransactionId', internalTransactionId)
          ..add('pan', pan)
          ..add('amount', amount))
        .toString();
  }
}

class CardAuthRequestBuilder
    implements Builder<CardAuthRequest, CardAuthRequestBuilder> {
  _$CardAuthRequest? _$v;

  String? _internalTransactionId;
  String? get internalTransactionId => _$this._internalTransactionId;
  set internalTransactionId(String? internalTransactionId) =>
      _$this._internalTransactionId = internalTransactionId;

  String? _pan;
  String? get pan => _$this._pan;
  set pan(String? pan) => _$this._pan = pan;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  CardAuthRequestBuilder() {
    CardAuthRequest._defaults(this);
  }

  CardAuthRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _internalTransactionId = $v.internalTransactionId;
      _pan = $v.pan;
      _amount = $v.amount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CardAuthRequest other) {
    _$v = other as _$CardAuthRequest;
  }

  @override
  void update(void Function(CardAuthRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CardAuthRequest build() => _build();

  _$CardAuthRequest _build() {
    final _$result = _$v ??
        _$CardAuthRequest._(
          internalTransactionId: BuiltValueNullFieldError.checkNotNull(
              internalTransactionId,
              r'CardAuthRequest',
              'internalTransactionId'),
          pan: BuiltValueNullFieldError.checkNotNull(
              pan, r'CardAuthRequest', 'pan'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'CardAuthRequest', 'amount'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
