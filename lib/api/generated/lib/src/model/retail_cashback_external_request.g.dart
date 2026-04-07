// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_cashback_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RetailCashbackExternalRequest extends RetailCashbackExternalRequest {
  @override
  final String merchantId;
  @override
  final String cashBackAmount;
  @override
  final String? cardData;
  @override
  final String? pinBlock;
  @override
  final String idempotencyKey;

  factory _$RetailCashbackExternalRequest(
          [void Function(RetailCashbackExternalRequestBuilder)? updates]) =>
      (RetailCashbackExternalRequestBuilder()..update(updates))._build();

  _$RetailCashbackExternalRequest._(
      {required this.merchantId,
      required this.cashBackAmount,
      this.cardData,
      this.pinBlock,
      required this.idempotencyKey})
      : super._();
  @override
  RetailCashbackExternalRequest rebuild(
          void Function(RetailCashbackExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RetailCashbackExternalRequestBuilder toBuilder() =>
      RetailCashbackExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RetailCashbackExternalRequest &&
        merchantId == other.merchantId &&
        cashBackAmount == other.cashBackAmount &&
        cardData == other.cardData &&
        pinBlock == other.pinBlock &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, cashBackAmount.hashCode);
    _$hash = $jc(_$hash, cardData.hashCode);
    _$hash = $jc(_$hash, pinBlock.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RetailCashbackExternalRequest')
          ..add('merchantId', merchantId)
          ..add('cashBackAmount', cashBackAmount)
          ..add('cardData', cardData)
          ..add('pinBlock', pinBlock)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class RetailCashbackExternalRequestBuilder
    implements
        Builder<RetailCashbackExternalRequest,
            RetailCashbackExternalRequestBuilder> {
  _$RetailCashbackExternalRequest? _$v;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  String? _cashBackAmount;
  String? get cashBackAmount => _$this._cashBackAmount;
  set cashBackAmount(String? cashBackAmount) =>
      _$this._cashBackAmount = cashBackAmount;

  String? _cardData;
  String? get cardData => _$this._cardData;
  set cardData(String? cardData) => _$this._cardData = cardData;

  String? _pinBlock;
  String? get pinBlock => _$this._pinBlock;
  set pinBlock(String? pinBlock) => _$this._pinBlock = pinBlock;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  RetailCashbackExternalRequestBuilder() {
    RetailCashbackExternalRequest._defaults(this);
  }

  RetailCashbackExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _merchantId = $v.merchantId;
      _cashBackAmount = $v.cashBackAmount;
      _cardData = $v.cardData;
      _pinBlock = $v.pinBlock;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RetailCashbackExternalRequest other) {
    _$v = other as _$RetailCashbackExternalRequest;
  }

  @override
  void update(void Function(RetailCashbackExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RetailCashbackExternalRequest build() => _build();

  _$RetailCashbackExternalRequest _build() {
    final _$result = _$v ??
        _$RetailCashbackExternalRequest._(
          merchantId: BuiltValueNullFieldError.checkNotNull(
              merchantId, r'RetailCashbackExternalRequest', 'merchantId'),
          cashBackAmount: BuiltValueNullFieldError.checkNotNull(cashBackAmount,
              r'RetailCashbackExternalRequest', 'cashBackAmount'),
          cardData: cardData,
          pinBlock: pinBlock,
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(idempotencyKey,
              r'RetailCashbackExternalRequest', 'idempotencyKey'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
