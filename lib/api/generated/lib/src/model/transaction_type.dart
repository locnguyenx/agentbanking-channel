//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'transaction_type.g.dart';

class TransactionType extends EnumClass {

  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'CASH_WITHDRAWAL')
  static const TransactionType CASH_WITHDRAWAL = _$CASH_WITHDRAWAL;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'CASH_DEPOSIT')
  static const TransactionType CASH_DEPOSIT = _$CASH_DEPOSIT;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'BILL_PAYMENT')
  static const TransactionType BILL_PAYMENT = _$BILL_PAYMENT;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'DUITNOW_TRANSFER')
  static const TransactionType DUITNOW_TRANSFER = _$DUITNOW_TRANSFER;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'CASHLESS_PAYMENT')
  static const TransactionType CASHLESS_PAYMENT = _$CASHLESS_PAYMENT;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'PIN_BASED_PURCHASE')
  static const TransactionType PIN_BASED_PURCHASE = _$PIN_BASED_PURCHASE;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'PREPAID_TOPUP')
  static const TransactionType PREPAID_TOPUP = _$PREPAID_TOPUP;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'EWALLET_WITHDRAWAL')
  static const TransactionType EWALLET_WITHDRAWAL = _$EWALLET_WITHDRAWAL;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'EWALLET_TOPUP')
  static const TransactionType EWALLET_TOPUP = _$EWALLET_TOPUP;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'ESSP_PURCHASE')
  static const TransactionType ESSP_PURCHASE = _$ESSP_PURCHASE;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'PIN_PURCHASE')
  static const TransactionType PIN_PURCHASE = _$PIN_PURCHASE;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'RETAIL_SALE')
  static const TransactionType RETAIL_SALE = _$RETAIL_SALE;
  /// Type of transaction to initiate
  @BuiltValueEnumConst(wireName: r'HYBRID_CASHBACK')
  static const TransactionType HYBRID_CASHBACK = _$HYBRID_CASHBACK;

  static Serializer<TransactionType> get serializer => _$transactionTypeSerializer;

  const TransactionType._(String name): super(name);

  static BuiltSet<TransactionType> get values => _$values;
  static TransactionType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class TransactionTypeMixin = Object with _$TransactionTypeMixin;

