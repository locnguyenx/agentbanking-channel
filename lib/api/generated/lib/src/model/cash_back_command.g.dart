// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cash_back_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CashBackCommand extends CashBackCommand {
  @override
  final String? merchantId;
  @override
  final num? cashBackAmount;
  @override
  final String? cardData;
  @override
  final String? pinBlock;
  @override
  final String? idempotencyKey;

  factory _$CashBackCommand([void Function(CashBackCommandBuilder)? updates]) =>
      (CashBackCommandBuilder()..update(updates))._build();

  _$CashBackCommand._(
      {this.merchantId,
      this.cashBackAmount,
      this.cardData,
      this.pinBlock,
      this.idempotencyKey})
      : super._();
  @override
  CashBackCommand rebuild(void Function(CashBackCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CashBackCommandBuilder toBuilder() => CashBackCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CashBackCommand &&
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
    return (newBuiltValueToStringHelper(r'CashBackCommand')
          ..add('merchantId', merchantId)
          ..add('cashBackAmount', cashBackAmount)
          ..add('cardData', cardData)
          ..add('pinBlock', pinBlock)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class CashBackCommandBuilder
    implements Builder<CashBackCommand, CashBackCommandBuilder> {
  _$CashBackCommand? _$v;

  String? _merchantId;
  String? get merchantId => _$this._merchantId;
  set merchantId(String? merchantId) => _$this._merchantId = merchantId;

  num? _cashBackAmount;
  num? get cashBackAmount => _$this._cashBackAmount;
  set cashBackAmount(num? cashBackAmount) =>
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

  CashBackCommandBuilder() {
    CashBackCommand._defaults(this);
  }

  CashBackCommandBuilder get _$this {
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
  void replace(CashBackCommand other) {
    _$v = other as _$CashBackCommand;
  }

  @override
  void update(void Function(CashBackCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CashBackCommand build() => _build();

  _$CashBackCommand _build() {
    final _$result = _$v ??
        _$CashBackCommand._(
          merchantId: merchantId,
          cashBackAmount: cashBackAmount,
          cardData: cardData,
          pinBlock: pinBlock,
          idempotencyKey: idempotencyKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
