// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retail_sale_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RetailSaleCommand extends RetailSaleCommand {
  @override
  final String? merchantId;
  @override
  final num? amount;
  @override
  final String? cardData;
  @override
  final String? pinBlock;
  @override
  final String? idempotencyKey;

  factory _$RetailSaleCommand(
          [void Function(RetailSaleCommandBuilder)? updates]) =>
      (RetailSaleCommandBuilder()..update(updates))._build();

  _$RetailSaleCommand._(
      {this.merchantId,
      this.amount,
      this.cardData,
      this.pinBlock,
      this.idempotencyKey})
      : super._();
  @override
  RetailSaleCommand rebuild(void Function(RetailSaleCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RetailSaleCommandBuilder toBuilder() =>
      RetailSaleCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RetailSaleCommand &&
        merchantId == other.merchantId &&
        amount == other.amount &&
        cardData == other.cardData &&
        pinBlock == other.pinBlock &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, merchantId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, cardData.hashCode);
    _$hash = $jc(_$hash, pinBlock.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RetailSaleCommand')
          ..add('merchantId', merchantId)
          ..add('amount', amount)
          ..add('cardData', cardData)
          ..add('pinBlock', pinBlock)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class RetailSaleCommandBuilder
    implements Builder<RetailSaleCommand, RetailSaleCommandBuilder> {
  _$RetailSaleCommand? _$v;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  num? _amount;
  num? get amount => _$this._amount;
  set amount(num? amount) => _$this._amount = amount;

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

  RetailSaleCommandBuilder() {
    RetailSaleCommand._defaults(this);
  }

  RetailSaleCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _merchantId = $v.merchantId;
      _amount = $v.amount;
      _cardData = $v.cardData;
      _pinBlock = $v.pinBlock;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RetailSaleCommand other) {
    _$v = other as _$RetailSaleCommand;
  }

  @override
  void update(void Function(RetailSaleCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RetailSaleCommand build() => _build();

  _$RetailSaleCommand _build() {
    final _$result = _$v ??
        _$RetailSaleCommand._(
          merchantId: merchantId,
          amount: amount,
          cardData: cardData,
          pinBlock: pinBlock,
          idempotencyKey: idempotencyKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
