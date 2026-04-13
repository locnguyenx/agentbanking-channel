// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const TransactionType _$CASH_WITHDRAWAL =
    const TransactionType._('CASH_WITHDRAWAL');
const TransactionType _$CASH_DEPOSIT = const TransactionType._('CASH_DEPOSIT');
const TransactionType _$BILL_PAYMENT = const TransactionType._('BILL_PAYMENT');
const TransactionType _$DUITNOW_TRANSFER =
    const TransactionType._('DUITNOW_TRANSFER');
const TransactionType _$CASHLESS_PAYMENT =
    const TransactionType._('CASHLESS_PAYMENT');
const TransactionType _$PIN_BASED_PURCHASE =
    const TransactionType._('PIN_BASED_PURCHASE');
const TransactionType _$PREPAID_TOPUP =
    const TransactionType._('PREPAID_TOPUP');
const TransactionType _$EWALLET_WITHDRAWAL =
    const TransactionType._('EWALLET_WITHDRAWAL');
const TransactionType _$EWALLET_TOPUP =
    const TransactionType._('EWALLET_TOPUP');
const TransactionType _$ESSP_PURCHASE =
    const TransactionType._('ESSP_PURCHASE');
const TransactionType _$PIN_PURCHASE = const TransactionType._('PIN_PURCHASE');
const TransactionType _$RETAIL_SALE = const TransactionType._('RETAIL_SALE');
const TransactionType _$HYBRID_CASHBACK =
    const TransactionType._('HYBRID_CASHBACK');
const TransactionType _$BALANCE_INQUIRY =
    const TransactionType._('BALANCE_INQUIRY');

TransactionType _$valueOf(String name) {
  switch (name) {
    case 'CASH_WITHDRAWAL':
      return _$CASH_WITHDRAWAL;
    case 'CASH_DEPOSIT':
      return _$CASH_DEPOSIT;
    case 'BILL_PAYMENT':
      return _$BILL_PAYMENT;
    case 'DUITNOW_TRANSFER':
      return _$DUITNOW_TRANSFER;
    case 'CASHLESS_PAYMENT':
      return _$CASHLESS_PAYMENT;
    case 'PIN_BASED_PURCHASE':
      return _$PIN_BASED_PURCHASE;
    case 'PREPAID_TOPUP':
      return _$PREPAID_TOPUP;
    case 'EWALLET_WITHDRAWAL':
      return _$EWALLET_WITHDRAWAL;
    case 'EWALLET_TOPUP':
      return _$EWALLET_TOPUP;
    case 'ESSP_PURCHASE':
      return _$ESSP_PURCHASE;
    case 'PIN_PURCHASE':
      return _$PIN_PURCHASE;
    case 'RETAIL_SALE':
      return _$RETAIL_SALE;
    case 'HYBRID_CASHBACK':
      return _$HYBRID_CASHBACK;
    case 'BALANCE_INQUIRY':
      return _$BALANCE_INQUIRY;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<TransactionType> _$values =
    BuiltSet<TransactionType>(const <TransactionType>[
  _$CASH_WITHDRAWAL,
  _$CASH_DEPOSIT,
  _$BILL_PAYMENT,
  _$DUITNOW_TRANSFER,
  _$CASHLESS_PAYMENT,
  _$PIN_BASED_PURCHASE,
  _$PREPAID_TOPUP,
  _$EWALLET_WITHDRAWAL,
  _$EWALLET_TOPUP,
  _$ESSP_PURCHASE,
  _$PIN_PURCHASE,
  _$RETAIL_SALE,
  _$HYBRID_CASHBACK,
  _$BALANCE_INQUIRY,
]);

class _$TransactionTypeMeta {
  const _$TransactionTypeMeta();
  TransactionType get CASH_WITHDRAWAL => _$CASH_WITHDRAWAL;
  TransactionType get CASH_DEPOSIT => _$CASH_DEPOSIT;
  TransactionType get BILL_PAYMENT => _$BILL_PAYMENT;
  TransactionType get DUITNOW_TRANSFER => _$DUITNOW_TRANSFER;
  TransactionType get CASHLESS_PAYMENT => _$CASHLESS_PAYMENT;
  TransactionType get PIN_BASED_PURCHASE => _$PIN_BASED_PURCHASE;
  TransactionType get PREPAID_TOPUP => _$PREPAID_TOPUP;
  TransactionType get EWALLET_WITHDRAWAL => _$EWALLET_WITHDRAWAL;
  TransactionType get EWALLET_TOPUP => _$EWALLET_TOPUP;
  TransactionType get ESSP_PURCHASE => _$ESSP_PURCHASE;
  TransactionType get PIN_PURCHASE => _$PIN_PURCHASE;
  TransactionType get RETAIL_SALE => _$RETAIL_SALE;
  TransactionType get HYBRID_CASHBACK => _$HYBRID_CASHBACK;
  TransactionType get BALANCE_INQUIRY => _$BALANCE_INQUIRY;
  TransactionType valueOf(String name) => _$valueOf(name);
  BuiltSet<TransactionType> get values => _$values;
}

abstract class _$TransactionTypeMixin {
  // ignore: non_constant_identifier_names
  _$TransactionTypeMeta get TransactionType => const _$TransactionTypeMeta();
}

Serializer<TransactionType> _$transactionTypeSerializer =
    _$TransactionTypeSerializer();

class _$TransactionTypeSerializer
    implements PrimitiveSerializer<TransactionType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'CASH_WITHDRAWAL': 'CASH_WITHDRAWAL',
    'CASH_DEPOSIT': 'CASH_DEPOSIT',
    'BILL_PAYMENT': 'BILL_PAYMENT',
    'DUITNOW_TRANSFER': 'DUITNOW_TRANSFER',
    'CASHLESS_PAYMENT': 'CASHLESS_PAYMENT',
    'PIN_BASED_PURCHASE': 'PIN_BASED_PURCHASE',
    'PREPAID_TOPUP': 'PREPAID_TOPUP',
    'EWALLET_WITHDRAWAL': 'EWALLET_WITHDRAWAL',
    'EWALLET_TOPUP': 'EWALLET_TOPUP',
    'ESSP_PURCHASE': 'ESSP_PURCHASE',
    'PIN_PURCHASE': 'PIN_PURCHASE',
    'RETAIL_SALE': 'RETAIL_SALE',
    'HYBRID_CASHBACK': 'HYBRID_CASHBACK',
    'BALANCE_INQUIRY': 'BALANCE_INQUIRY',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'CASH_WITHDRAWAL': 'CASH_WITHDRAWAL',
    'CASH_DEPOSIT': 'CASH_DEPOSIT',
    'BILL_PAYMENT': 'BILL_PAYMENT',
    'DUITNOW_TRANSFER': 'DUITNOW_TRANSFER',
    'CASHLESS_PAYMENT': 'CASHLESS_PAYMENT',
    'PIN_BASED_PURCHASE': 'PIN_BASED_PURCHASE',
    'PREPAID_TOPUP': 'PREPAID_TOPUP',
    'EWALLET_WITHDRAWAL': 'EWALLET_WITHDRAWAL',
    'EWALLET_TOPUP': 'EWALLET_TOPUP',
    'ESSP_PURCHASE': 'ESSP_PURCHASE',
    'PIN_PURCHASE': 'PIN_PURCHASE',
    'RETAIL_SALE': 'RETAIL_SALE',
    'HYBRID_CASHBACK': 'HYBRID_CASHBACK',
    'BALANCE_INQUIRY': 'BALANCE_INQUIRY',
  };

  @override
  final Iterable<Type> types = const <Type>[TransactionType];
  @override
  final String wireName = 'TransactionType';

  @override
  Object serialize(Serializers serializers, TransactionType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  TransactionType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      TransactionType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
