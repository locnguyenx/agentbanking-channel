//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'retail_sale_command.g.dart';

/// RetailSaleCommand
///
/// Properties:
/// * [merchantId]
/// * [amount]
/// * [cardData]
/// * [pinBlock]
/// * [idempotencyKey]
@BuiltValue()
abstract class RetailSaleCommand
    implements Built<RetailSaleCommand, RetailSaleCommandBuilder> {
  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'amount')
  num? get amount;

  @BuiltValueField(wireName: r'cardData')
  String? get cardData;

  @BuiltValueField(wireName: r'pinBlock')
  String? get pinBlock;

  @BuiltValueField(wireName: r'idempotencyKey')
  String? get idempotencyKey;

  RetailSaleCommand._();

  factory RetailSaleCommand([void updates(RetailSaleCommandBuilder b)]) =
      _$RetailSaleCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RetailSaleCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RetailSaleCommand> get serializer =>
      _$RetailSaleCommandSerializer();
}

class _$RetailSaleCommandSerializer
    implements PrimitiveSerializer<RetailSaleCommand> {
  @override
  final Iterable<Type> types = const [RetailSaleCommand, _$RetailSaleCommand];

  @override
  final String wireName = r'RetailSaleCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RetailSaleCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.merchantId != null) {
      yield r'merchantId';
      yield serializers.serialize(
        object.merchantId,
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
    if (object.cardData != null) {
      yield r'cardData';
      yield serializers.serialize(
        object.cardData,
        specifiedType: const FullType(String),
      );
    }
    if (object.pinBlock != null) {
      yield r'pinBlock';
      yield serializers.serialize(
        object.pinBlock,
        specifiedType: const FullType(String),
      );
    }
    if (object.idempotencyKey != null) {
      yield r'idempotencyKey';
      yield serializers.serialize(
        object.idempotencyKey,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    RetailSaleCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RetailSaleCommandBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'merchantId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.merchantId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.amount = valueDes;
          break;
        case r'cardData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.cardData = valueDes;
          break;
        case r'pinBlock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pinBlock = valueDes;
          break;
        case r'idempotencyKey':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.idempotencyKey = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RetailSaleCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RetailSaleCommandBuilder();
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
