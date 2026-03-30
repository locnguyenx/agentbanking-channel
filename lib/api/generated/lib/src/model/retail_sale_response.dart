//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'retail_sale_response.g.dart';

/// RetailSaleResponse
///
/// Properties:
/// * [status] 
/// * [transactionId] 
/// * [amount] 
/// * [mdrAmount] 
/// * [netToMerchant] 
@BuiltValue()
abstract class RetailSaleResponse implements Built<RetailSaleResponse, RetailSaleResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'transactionId')
  String? get transactionId;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'mdrAmount')
  num? get mdrAmount;

  @BuiltValueField(wireName: r'netToMerchant')
  num? get netToMerchant;

  RetailSaleResponse._();

  factory RetailSaleResponse([void updates(RetailSaleResponseBuilder b)]) = _$RetailSaleResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RetailSaleResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RetailSaleResponse> get serializer => _$RetailSaleResponseSerializer();
}

class _$RetailSaleResponseSerializer implements PrimitiveSerializer<RetailSaleResponse> {
  @override
  final Iterable<Type> types = const [RetailSaleResponse, _$RetailSaleResponse];

  @override
  final String wireName = r'RetailSaleResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RetailSaleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.transactionId != null) {
      yield r'transactionId';
      yield serializers.serialize(
        object.transactionId,
        specifiedType: const FullType(String),
      );
    }
    if (object.amount != null) {
      yield r'amount';
      yield serializers.serialize(
        object.amount,
        specifiedType: const FullType(num),
      );
    }
    if (object.mdrAmount != null) {
      yield r'mdrAmount';
      yield serializers.serialize(
        object.mdrAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.netToMerchant != null) {
      yield r'netToMerchant';
      yield serializers.serialize(
        object.netToMerchant,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RetailSaleResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RetailSaleResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'transactionId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.transactionId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'mdrAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.mdrAmount = valueDes;
          break;
        case r'netToMerchant':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.netToMerchant = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RetailSaleResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RetailSaleResponseBuilder();
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

