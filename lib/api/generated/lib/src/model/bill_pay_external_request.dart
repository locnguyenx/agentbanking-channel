//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bill_pay_external_request.g.dart';

/// BillPayExternalRequest
///
/// Properties:
/// * [billerCode] - Biller code (4 digits)
/// * [ref1] - Reference 1 (bill account number)
/// * [ref2] - Reference 2 (optional)
/// * [amount] - Payment amount in MYR
/// * [currency] 
/// * [idempotencyKey] 
/// * [customerMobile] - Customer mobile number
@BuiltValue()
abstract class BillPayExternalRequest implements Built<BillPayExternalRequest, BillPayExternalRequestBuilder> {
  /// Biller code (4 digits)
  @BuiltValueField(wireName: r'billerCode')
  String get billerCode;

  /// Reference 1 (bill account number)
  @BuiltValueField(wireName: r'ref1')
  String get ref1;

  /// Reference 2 (optional)
  @BuiltValueField(wireName: r'ref2')
  String? get ref2;

  /// Payment amount in MYR
  @BuiltValueField(wireName: r'amount')
  num get amount;

  @BuiltValueField(wireName: r'currency')
  BillPayExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  /// Customer mobile number
  @BuiltValueField(wireName: r'customerMobile')
  String? get customerMobile;

  BillPayExternalRequest._();

  factory BillPayExternalRequest([void updates(BillPayExternalRequestBuilder b)]) = _$BillPayExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BillPayExternalRequestBuilder b) => b
      ..currency = BillPayExternalRequestCurrencyEnum.valueOf('MYR');

  @BuiltValueSerializer(custom: true)
  static Serializer<BillPayExternalRequest> get serializer => _$BillPayExternalRequestSerializer();
}

class _$BillPayExternalRequestSerializer implements PrimitiveSerializer<BillPayExternalRequest> {
  @override
  final Iterable<Type> types = const [BillPayExternalRequest, _$BillPayExternalRequest];

  @override
  final String wireName = r'BillPayExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BillPayExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'billerCode';
    yield serializers.serialize(
      object.billerCode,
      specifiedType: const FullType(String),
    );
    yield r'ref1';
    yield serializers.serialize(
      object.ref1,
      specifiedType: const FullType(String),
    );
    if (object.ref2 != null) {
      yield r'ref2';
      yield serializers.serialize(
        object.ref2,
        specifiedType: const FullType(String),
      );
    }
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(num),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(BillPayExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
    if (object.customerMobile != null) {
      yield r'customerMobile';
      yield serializers.serialize(
        object.customerMobile,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BillPayExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BillPayExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'billerCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.billerCode = valueDes;
          break;
        case r'ref1':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref1 = valueDes;
          break;
        case r'ref2':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.ref2 = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BillPayExternalRequestCurrencyEnum),
          ) as BillPayExternalRequestCurrencyEnum;
          result.currency = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        case r'customerMobile':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.customerMobile = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BillPayExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BillPayExternalRequestBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class BillPayExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const BillPayExternalRequestCurrencyEnum MYR = _$billPayExternalRequestCurrencyEnum_MYR;

  static Serializer<BillPayExternalRequestCurrencyEnum> get serializer => _$billPayExternalRequestCurrencyEnumSerializer;

  const BillPayExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<BillPayExternalRequestCurrencyEnum> get values => _$billPayExternalRequestCurrencyEnumValues;
  static BillPayExternalRequestCurrencyEnum valueOf(String name) => _$billPayExternalRequestCurrencyEnumValueOf(name);
}

