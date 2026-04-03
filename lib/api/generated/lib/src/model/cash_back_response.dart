//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'cash_back_response.g.dart';

/// CashBackResponse
///
/// Properties:
/// * [status]
/// * [transactionId]
/// * [cashBackAmount]
/// * [commission]
@BuiltValue()
abstract class CashBackResponse
    implements Built<CashBackResponse, CashBackResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'transactionId')
  String? get transactionId;

  @BuiltValueField(wireName: r'cashBackAmount')
  num? get cashBackAmount;

  @BuiltValueField(wireName: r'commission')
  num? get commission;

  CashBackResponse._();

  factory CashBackResponse([void updates(CashBackResponseBuilder b)]) =
      _$CashBackResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CashBackResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CashBackResponse> get serializer =>
      _$CashBackResponseSerializer();
}

class _$CashBackResponseSerializer
    implements PrimitiveSerializer<CashBackResponse> {
  @override
  final Iterable<Type> types = const [CashBackResponse, _$CashBackResponse];

  @override
  final String wireName = r'CashBackResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CashBackResponse object, {
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
    if (object.cashBackAmount != null) {
      yield r'cashBackAmount';
      yield serializers.serialize(
        object.cashBackAmount,
        specifiedType: const FullType(num),
      );
    }
    if (object.commission != null) {
      yield r'commission';
      yield serializers.serialize(
        object.commission,
        specifiedType: const FullType(num),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CashBackResponse object, {
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
    required CashBackResponseBuilder result,
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
        case r'cashBackAmount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.cashBackAmount = valueDes;
          break;
        case r'commission':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.commission = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CashBackResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CashBackResponseBuilder();
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
