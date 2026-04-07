// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_pay_external_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BillPayExternalRequestCurrencyEnum
    _$billPayExternalRequestCurrencyEnum_MYR =
    const BillPayExternalRequestCurrencyEnum._('MYR');

BillPayExternalRequestCurrencyEnum _$billPayExternalRequestCurrencyEnumValueOf(
    String name) {
  switch (name) {
    case 'MYR':
      return _$billPayExternalRequestCurrencyEnum_MYR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BillPayExternalRequestCurrencyEnum>
    _$billPayExternalRequestCurrencyEnumValues = BuiltSet<
        BillPayExternalRequestCurrencyEnum>(const <BillPayExternalRequestCurrencyEnum>[
  _$billPayExternalRequestCurrencyEnum_MYR,
]);

Serializer<BillPayExternalRequestCurrencyEnum>
    _$billPayExternalRequestCurrencyEnumSerializer =
    _$BillPayExternalRequestCurrencyEnumSerializer();

class _$BillPayExternalRequestCurrencyEnumSerializer
    implements PrimitiveSerializer<BillPayExternalRequestCurrencyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'MYR': 'MYR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'MYR': 'MYR',
  };

  @override
  final Iterable<Type> types = const <Type>[BillPayExternalRequestCurrencyEnum];
  @override
  final String wireName = 'BillPayExternalRequestCurrencyEnum';

  @override
  Object serialize(
          Serializers serializers, BillPayExternalRequestCurrencyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BillPayExternalRequestCurrencyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BillPayExternalRequestCurrencyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$BillPayExternalRequest extends BillPayExternalRequest {
  @override
  final String billerCode;
  @override
  final String ref1;
  @override
  final String? ref2;
  @override
  final String amount;
  @override
  final BillPayExternalRequestCurrencyEnum currency;
  @override
  final String idempotencyKey;
  @override
  final String? customerMobile;

  factory _$BillPayExternalRequest(
          [void Function(BillPayExternalRequestBuilder)? updates]) =>
      (BillPayExternalRequestBuilder()..update(updates))._build();

  _$BillPayExternalRequest._(
      {required this.billerCode,
      required this.ref1,
      this.ref2,
      required this.amount,
      required this.currency,
      required this.idempotencyKey,
      this.customerMobile})
      : super._();
  @override
  BillPayExternalRequest rebuild(
          void Function(BillPayExternalRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BillPayExternalRequestBuilder toBuilder() =>
      BillPayExternalRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BillPayExternalRequest &&
        billerCode == other.billerCode &&
        ref1 == other.ref1 &&
        ref2 == other.ref2 &&
        amount == other.amount &&
        currency == other.currency &&
        idempotencyKey == other.idempotencyKey &&
        customerMobile == other.customerMobile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, billerCode.hashCode);
    _$hash = $jc(_$hash, ref1.hashCode);
    _$hash = $jc(_$hash, ref2.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, currency.hashCode);
    _$hash = $jc(_$hash, idempotencyKey.hashCode);
    _$hash = $jc(_$hash, customerMobile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'BillPayExternalRequest')
          ..add('billerCode', billerCode)
          ..add('ref1', ref1)
          ..add('ref2', ref2)
          ..add('amount', amount)
          ..add('currency', currency)
          ..add('idempotencyKey', idempotencyKey)
          ..add('customerMobile', customerMobile))
        .toString();
  }
}

class BillPayExternalRequestBuilder
    implements Builder<BillPayExternalRequest, BillPayExternalRequestBuilder> {
  _$BillPayExternalRequest? _$v;

  String? _billerCode;
  String? get billerCode => _$this._billerCode;
  set billerCode(String? billerCode) => _$this._billerCode = billerCode;

  String? _ref1;
  String? get ref1 => _$this._ref1;
  set ref1(String? ref1) => _$this._ref1 = ref1;

  String? _ref2;
  String? get ref2 => _$this._ref2;
  set ref2(String? ref2) => _$this._ref2 = ref2;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  BillPayExternalRequestCurrencyEnum? _currency;
  BillPayExternalRequestCurrencyEnum? get currency => _$this._currency;
  set currency(BillPayExternalRequestCurrencyEnum? currency) =>
      _$this._currency = currency;

  String? _idempotencyKey;
  String? get idempotencyKey => _$this._idempotencyKey;
  set idempotencyKey(String? idempotencyKey) =>
      _$this._idempotencyKey = idempotencyKey;

  String? _customerMobile;
  String? get customerMobile => _$this._customerMobile;
  set customerMobile(String? customerMobile) =>
      _$this._customerMobile = customerMobile;

  BillPayExternalRequestBuilder() {
    BillPayExternalRequest._defaults(this);
  }

  BillPayExternalRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _billerCode = $v.billerCode;
      _ref1 = $v.ref1;
      _ref2 = $v.ref2;
      _amount = $v.amount;
      _currency = $v.currency;
      _idempotencyKey = $v.idempotencyKey;
      _customerMobile = $v.customerMobile;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BillPayExternalRequest other) {
    _$v = other as _$BillPayExternalRequest;
  }

  @override
  void update(void Function(BillPayExternalRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  BillPayExternalRequest build() => _build();

  _$BillPayExternalRequest _build() {
    final _$result = _$v ??
        _$BillPayExternalRequest._(
          billerCode: BuiltValueNullFieldError.checkNotNull(
              billerCode, r'BillPayExternalRequest', 'billerCode'),
          ref1: BuiltValueNullFieldError.checkNotNull(
              ref1, r'BillPayExternalRequest', 'ref1'),
          ref2: ref2,
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'BillPayExternalRequest', 'amount'),
          currency: BuiltValueNullFieldError.checkNotNull(
              currency, r'BillPayExternalRequest', 'currency'),
          idempotencyKey: BuiltValueNullFieldError.checkNotNull(
              idempotencyKey, r'BillPayExternalRequest', 'idempotencyKey'),
          customerMobile: customerMobile,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
