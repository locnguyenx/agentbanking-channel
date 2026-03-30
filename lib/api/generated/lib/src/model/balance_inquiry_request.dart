// @dart=2.19
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'balance_inquiry_request.g.dart';

/// BalanceInquiryRequest
///
/// Properties:
/// * [encryptedCardData] 
/// * [pinBlock] 
@BuiltValue()
abstract class BalanceInquiryRequest implements Built<BalanceInquiryRequest, BalanceInquiryRequestBuilder> {
  @BuiltValueField(wireName: r'encryptedCardData')
  String get encryptedCardData;

  @BuiltValueField(wireName: r'pinBlock')
  String get pinBlock;

  BalanceInquiryRequest._();

  factory BalanceInquiryRequest([void updates(BalanceInquiryRequestBuilder b)]) = _$BalanceInquiryRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BalanceInquiryRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BalanceInquiryRequest> get serializer => _$BalanceInquiryRequestSerializer();
}

class _$BalanceInquiryRequestSerializer implements PrimitiveSerializer<BalanceInquiryRequest> {
  @override
  final Iterable<Type> types = const [BalanceInquiryRequest, _$BalanceInquiryRequest];

  @override
  final String wireName = r'BalanceInquiryRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BalanceInquiryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'encryptedCardData';
    yield serializers.serialize(
      object.encryptedCardData,
      specifiedType: const FullType(String),
    );
    yield r'pinBlock';
    yield serializers.serialize(
      object.pinBlock,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BalanceInquiryRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BalanceInquiryRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'encryptedCardData':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.encryptedCardData = valueDes;
          break;
        case r'pinBlock':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.pinBlock = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BalanceInquiryRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BalanceInquiryRequestBuilder();
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

