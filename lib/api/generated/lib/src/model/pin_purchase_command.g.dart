// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_purchase_command.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PinPurchaseCommand extends PinPurchaseCommand {
  @override
  final String? agentId;
  @override
  final String? productCode;
  @override
  final String? amount;
  @override
  final String? idempotencyKey;

  factory _$PinPurchaseCommand(
          [void Function(PinPurchaseCommandBuilder)? updates]) =>
      (PinPurchaseCommandBuilder()..update(updates))._build();

  _$PinPurchaseCommand._(
      {this.agentId, this.productCode, this.amount, this.idempotencyKey})
      : super._();
  @override
  PinPurchaseCommand rebuild(
          void Function(PinPurchaseCommandBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PinPurchaseCommandBuilder toBuilder() =>
      PinPurchaseCommandBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PinPurchaseCommand &&
        agentId == other.agentId &&
        productCode == other.productCode &&
        amount == other.amount &&
        idempotencyKey == other.idempotencyKey;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, productCode.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PinPurchaseCommand')
          ..add('agentId', agentId)
          ..add('productCode', productCode)
          ..add('amount', amount)
          ..add('idempotencyKey', idempotencyKey))
        .toString();
  }
}

class PinPurchaseCommandBuilder
    implements Builder<PinPurchaseCommand, PinPurchaseCommandBuilder> {
  _$PinPurchaseCommand? _$v;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  String? _productCode;
  String? get productCode => _$this._productCode;
  set productCode(String? productCode) => _$this._productCode = productCode;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  PinPurchaseCommandBuilder() {
    PinPurchaseCommand._defaults(this);
  }

  PinPurchaseCommandBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _agentId = $v.agentId;
      _productCode = $v.productCode;
      _amount = $v.amount;
      _idempotencyKey = $v.idempotencyKey;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PinPurchaseCommand other) {
    _$v = other as _$PinPurchaseCommand;
  }

  @override
  void update(void Function(PinPurchaseCommandBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PinPurchaseCommand build() => _build();

  _$PinPurchaseCommand _build() {
    final _$result = _$v ??
        _$PinPurchaseCommand._(
          agentId: agentId,
          productCode: productCode,
          amount: amount,
          idempotencyKey: idempotencyKey,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
