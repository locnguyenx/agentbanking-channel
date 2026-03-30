// @dart=2.19
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_purchase_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PinPurchaseResponse extends PinPurchaseResponse {
  @override
  final String? status;
  @override
  final String? transactionId;
  @override
  final String? pinCode;
  @override
  final num? commission;
  @override
  final String? timestamp;

  factory _$PinPurchaseResponse(
          [void Function(PinPurchaseResponseBuilder)? updates]) =>
      (PinPurchaseResponseBuilder()..update(updates))._build();

  _$PinPurchaseResponse._(
      {this.status,
      this.transactionId,
      this.pinCode,
      this.commission,
      this.timestamp})
      : super._();
  @override
  PinPurchaseResponse rebuild(
          void Function(PinPurchaseResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PinPurchaseResponseBuilder toBuilder() =>
      PinPurchaseResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PinPurchaseResponse &&
        status == other.status &&
        transactionId == other.transactionId &&
        pinCode == other.pinCode &&
        commission == other.commission &&
        timestamp == other.timestamp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, transactionId.hashCode);
    _$hash = $jc(_$hash, pinCode.hashCode);
    _$hash = $jc(_$hash, commission.hashCode);
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PinPurchaseResponse')
          ..add('status', status)
          ..add('transactionId', transactionId)
          ..add('pinCode', pinCode)
          ..add('commission', commission)
          ..add('timestamp', timestamp))
        .toString();
  }
}

class PinPurchaseResponseBuilder
    implements Builder<PinPurchaseResponse, PinPurchaseResponseBuilder> {
  _$PinPurchaseResponse? _$v;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  String? _transactionId;
  String? get transactionId => _$this._transactionId;
  set transactionId(String? transactionId) =>
      _$this._transactionId = transactionId;

  String? _pinCode;
  String? get pinCode => _$this._pinCode;
  set pinCode(String? pinCode) => _$this._pinCode = pinCode;

  num? _commission;
  num? get commission => _$this._commission;
  set commission(num? commission) => _$this._commission = commission;

  String? _timestamp;
  String? get timestamp => _$this._timestamp;
  set timestamp(String? timestamp) => _$this._timestamp = timestamp;

  PinPurchaseResponseBuilder() {
    PinPurchaseResponse._defaults(this);
  }

  PinPurchaseResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _transactionId = $v.transactionId;
      _pinCode = $v.pinCode;
      _commission = $v.commission;
      _timestamp = $v.timestamp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PinPurchaseResponse other) {
    _$v = other as _$PinPurchaseResponse;
  }

  @override
  void update(void Function(PinPurchaseResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PinPurchaseResponse build() => _build();

  _$PinPurchaseResponse _build() {
    final _$result = _$v ??
        _$PinPurchaseResponse._(
          status: status,
          transactionId: transactionId,
          pinCode: pinCode,
          commission: commission,
          timestamp: timestamp,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
