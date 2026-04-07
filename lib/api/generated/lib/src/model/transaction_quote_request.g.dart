// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_quote_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_CARD_EMV =
    const TransactionQuoteRequestFundingSourceEnum._('CARD_EMV');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_CASH =
    const TransactionQuoteRequestFundingSourceEnum._('CASH');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MOBILE =
    const TransactionQuoteRequestFundingSourceEnum._('DUITNOW_MOBILE');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MYKAD =
    const TransactionQuoteRequestFundingSourceEnum._('DUITNOW_MYKAD');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_DUITNOW_BRN =
    const TransactionQuoteRequestFundingSourceEnum._('DUITNOW_BRN');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_MYKAD_BIOMETRIC =
    const TransactionQuoteRequestFundingSourceEnum._('MYKAD_BIOMETRIC');
const TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnum_DUITNOW_QR =
    const TransactionQuoteRequestFundingSourceEnum._('DUITNOW_QR');

TransactionQuoteRequestFundingSourceEnum
    _$transactionQuoteRequestFundingSourceEnumValueOf(String name) {
  switch (name) {
    case 'CARD_EMV':
      return _$transactionQuoteRequestFundingSourceEnum_CARD_EMV;
    case 'CASH':
      return _$transactionQuoteRequestFundingSourceEnum_CASH;
    case 'DUITNOW_MOBILE':
      return _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MOBILE;
    case 'DUITNOW_MYKAD':
      return _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MYKAD;
    case 'DUITNOW_BRN':
      return _$transactionQuoteRequestFundingSourceEnum_DUITNOW_BRN;
    case 'MYKAD_BIOMETRIC':
      return _$transactionQuoteRequestFundingSourceEnum_MYKAD_BIOMETRIC;
    case 'DUITNOW_QR':
      return _$transactionQuoteRequestFundingSourceEnum_DUITNOW_QR;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionQuoteRequestFundingSourceEnum>
    _$transactionQuoteRequestFundingSourceEnumValues = BuiltSet<
        TransactionQuoteRequestFundingSourceEnum>(const <TransactionQuoteRequestFundingSourceEnum>[
  _$transactionQuoteRequestFundingSourceEnum_CARD_EMV,
  _$transactionQuoteRequestFundingSourceEnum_CASH,
  _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MOBILE,
  _$transactionQuoteRequestFundingSourceEnum_DUITNOW_MYKAD,
  _$transactionQuoteRequestFundingSourceEnum_DUITNOW_BRN,
  _$transactionQuoteRequestFundingSourceEnum_MYKAD_BIOMETRIC,
  _$transactionQuoteRequestFundingSourceEnum_DUITNOW_QR,
]);

const TransactionQuoteRequestBillerRoutingEnum
    _$transactionQuoteRequestBillerRoutingEnum_ON_US =
    const TransactionQuoteRequestBillerRoutingEnum._('ON_US');
const TransactionQuoteRequestBillerRoutingEnum
    _$transactionQuoteRequestBillerRoutingEnum_OFF_US =
    const TransactionQuoteRequestBillerRoutingEnum._('OFF_US');

TransactionQuoteRequestBillerRoutingEnum
    _$transactionQuoteRequestBillerRoutingEnumValueOf(String name) {
  switch (name) {
    case 'ON_US':
      return _$transactionQuoteRequestBillerRoutingEnum_ON_US;
    case 'OFF_US':
      return _$transactionQuoteRequestBillerRoutingEnum_OFF_US;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionQuoteRequestBillerRoutingEnum>
    _$transactionQuoteRequestBillerRoutingEnumValues = BuiltSet<
        TransactionQuoteRequestBillerRoutingEnum>(const <TransactionQuoteRequestBillerRoutingEnum>[
  _$transactionQuoteRequestBillerRoutingEnum_ON_US,
  _$transactionQuoteRequestBillerRoutingEnum_OFF_US,
]);

Serializer<TransactionQuoteRequestFundingSourceEnum>
    _$transactionQuoteRequestFundingSourceEnumSerializer =
    _$TransactionQuoteRequestFundingSourceEnumSerializer();
Serializer<TransactionQuoteRequestBillerRoutingEnum>
    _$transactionQuoteRequestBillerRoutingEnumSerializer =
    _$TransactionQuoteRequestBillerRoutingEnumSerializer();

class _$TransactionQuoteRequestFundingSourceEnumSerializer
    implements PrimitiveSerializer<TransactionQuoteRequestFundingSourceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CARD_EMV': 'CARD_EMV',
    'CASH': 'CASH',
    'DUITNOW_MOBILE': 'DUITNOW_MOBILE',
    'DUITNOW_MYKAD': 'DUITNOW_MYKAD',
    'DUITNOW_BRN': 'DUITNOW_BRN',
    'MYKAD_BIOMETRIC': 'MYKAD_BIOMETRIC',
    'DUITNOW_QR': 'DUITNOW_QR',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CARD_EMV': 'CARD_EMV',
    'CASH': 'CASH',
    'DUITNOW_MOBILE': 'DUITNOW_MOBILE',
    'DUITNOW_MYKAD': 'DUITNOW_MYKAD',
    'DUITNOW_BRN': 'DUITNOW_BRN',
    'MYKAD_BIOMETRIC': 'MYKAD_BIOMETRIC',
    'DUITNOW_QR': 'DUITNOW_QR',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TransactionQuoteRequestFundingSourceEnum
  ];
  @override
  final String wireName = 'TransactionQuoteRequestFundingSourceEnum';

  @override
  Object serialize(Serializers serializers,
          TransactionQuoteRequestFundingSourceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionQuoteRequestFundingSourceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionQuoteRequestFundingSourceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionQuoteRequestBillerRoutingEnumSerializer
    implements PrimitiveSerializer<TransactionQuoteRequestBillerRoutingEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'ON_US': 'ON_US',
    'OFF_US': 'OFF_US',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'ON_US': 'ON_US',
    'OFF_US': 'OFF_US',
  };

  @override
  final Iterable<Type> types = const <Type>[
    TransactionQuoteRequestBillerRoutingEnum
  ];
  @override
  final String wireName = 'TransactionQuoteRequestBillerRoutingEnum';

  @override
  Object serialize(Serializers serializers,
          TransactionQuoteRequestBillerRoutingEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionQuoteRequestBillerRoutingEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionQuoteRequestBillerRoutingEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$TransactionQuoteRequest extends TransactionQuoteRequest {
  @override
  final String serviceCode;
  @override
  final String amount;
  @override
  final String agentId;
  @override
  final TransactionQuoteRequestFundingSourceEnum fundingSource;
  @override
  final TransactionQuoteRequestBillerRoutingEnum? billerRouting;

  factory _$TransactionQuoteRequest(
          [void Function(TransactionQuoteRequestBuilder)? updates]) =>
      (TransactionQuoteRequestBuilder()..update(updates))._build();

  _$TransactionQuoteRequest._(
      {required this.serviceCode,
      required this.amount,
      required this.agentId,
      required this.fundingSource,
      this.billerRouting})
      : super._();
  @override
  TransactionQuoteRequest rebuild(
          void Function(TransactionQuoteRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransactionQuoteRequestBuilder toBuilder() =>
      TransactionQuoteRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TransactionQuoteRequest &&
        serviceCode == other.serviceCode &&
        amount == other.amount &&
        agentId == other.agentId &&
        fundingSource == other.fundingSource &&
        billerRouting == other.billerRouting;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, serviceCode.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, agentId.hashCode);
    _$hash = $jc(_$hash, fundingSource.hashCode);
    _$hash = $jc(_$hash, billerRouting.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TransactionQuoteRequest')
          ..add('serviceCode', serviceCode)
          ..add('amount', amount)
          ..add('agentId', agentId)
          ..add('fundingSource', fundingSource)
          ..add('billerRouting', billerRouting))
        .toString();
  }
}

class TransactionQuoteRequestBuilder
    implements
        Builder<TransactionQuoteRequest, TransactionQuoteRequestBuilder> {
  _$TransactionQuoteRequest? _$v;

  String? _serviceCode;
  String? get serviceCode => _$this._serviceCode;
  set serviceCode(String? serviceCode) => _$this._serviceCode = serviceCode;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _agentId;
  String? get agentId => _$this._agentId;
  set agentId(String? agentId) => _$this._agentId = agentId;

  TransactionQuoteRequestFundingSourceEnum? _fundingSource;
  TransactionQuoteRequestFundingSourceEnum? get fundingSource =>
      _$this._fundingSource;
  set fundingSource(TransactionQuoteRequestFundingSourceEnum? fundingSource) =>
      _$this._fundingSource = fundingSource;

  TransactionQuoteRequestBillerRoutingEnum? _billerRouting;
  TransactionQuoteRequestBillerRoutingEnum? get billerRouting =>
      _$this._billerRouting;
  set billerRouting(TransactionQuoteRequestBillerRoutingEnum? billerRouting) =>
      _$this._billerRouting = billerRouting;

  TransactionQuoteRequestBuilder() {
    TransactionQuoteRequest._defaults(this);
  }

  TransactionQuoteRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serviceCode = $v.serviceCode;
      _amount = $v.amount;
      _agentId = $v.agentId;
      _fundingSource = $v.fundingSource;
      _billerRouting = $v.billerRouting;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TransactionQuoteRequest other) {
    _$v = other as _$TransactionQuoteRequest;
  }

  @override
  void update(void Function(TransactionQuoteRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TransactionQuoteRequest build() => _build();

  _$TransactionQuoteRequest _build() {
    final _$result = _$v ??
        _$TransactionQuoteRequest._(
          serviceCode: BuiltValueNullFieldError.checkNotNull(
              serviceCode, r'TransactionQuoteRequest', 'serviceCode'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'TransactionQuoteRequest', 'amount'),
          agentId: BuiltValueNullFieldError.checkNotNull(
              agentId, r'TransactionQuoteRequest', 'agentId'),
          fundingSource: BuiltValueNullFieldError.checkNotNull(
              fundingSource, r'TransactionQuoteRequest', 'fundingSource'),
          billerRouting: billerRouting,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
