//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cash_back_command.g.dart';

/// CashBackCommand
///
/// Properties:
/// * [merchantId] 
/// * [cashBackAmount] 
/// * [cardData] 
/// * [pinBlock] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class CashBackCommand implements Built<CashBackCommand, CashBackCommandBuilder> {
  @BuiltValueField(wireName: r'merchantId')
  String? get merchantId;

  @BuiltValueField(wireName: r'cashBackAmount')
  num? get cashBackAmount;

  @BuiltValueField(wireName: r'cardData')
  String? get cardData;

  @BuiltValueField(wireName: r'pinBlock')
  String? get pinBlock;

  @BuiltValueField(wireName: r'idempotencyKey')
  String? get idempotencyKey;

  CashBackCommand._();

  factory CashBackCommand([void updates(CashBackCommandBuilder b)]) = _$CashBackCommand;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CashBackCommandBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CashBackCommand> get serializer => _$CashBackCommandSerializer();
}

class _$CashBackCommandSerializer implements PrimitiveSerializer<CashBackCommand> {
  @override
  final Iterable<Type> types = const [CashBackCommand, _$CashBackCommand];

  @override
  final String wireName = r'CashBackCommand';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CashBackCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.merchantId != null) {
      yield r'merchantId';
      yield serializers.serialize(
        object.merchantId,
        specifiedType: const FullType(String),
      );
    }
    if (object.cashBackAmount != null) {
      yield r'cashBackAmount';
      yield serializers.serialize(
        object.cashBackAmount,
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
    CashBackCommand object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CashBackCommandBuilder result,
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
        case r'cashBackAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.cashBackAmount = valueDes;
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
  CashBackCommand deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CashBackCommandBuilder();
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

