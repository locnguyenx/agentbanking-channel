//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'balance_inquiry_external_request.g.dart';

/// BalanceInquiryExternalRequest
///
/// Properties:
/// * [encryptedCardData]
/// * [pinBlock]
@BuiltValue()
abstract class BalanceInquiryExternalRequest
    implements
        Built<BalanceInquiryExternalRequest,
            BalanceInquiryExternalRequestBuilder> {
  @BuiltValueField(wireName: r'encryptedCardData')
  String get encryptedCardData;

  @BuiltValueField(wireName: r'pinBlock')
  String get pinBlock;

  BalanceInquiryExternalRequest._();

  factory BalanceInquiryExternalRequest(
          [void updates(BalanceInquiryExternalRequestBuilder b)]) =
      _$BalanceInquiryExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BalanceInquiryExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BalanceInquiryExternalRequest> get serializer =>
      _$BalanceInquiryExternalRequestSerializer();
}

class _$BalanceInquiryExternalRequestSerializer
    implements PrimitiveSerializer<BalanceInquiryExternalRequest> {
  @override
  final Iterable<Type> types = const [
    BalanceInquiryExternalRequest,
    _$BalanceInquiryExternalRequest
  ];

  @override
  final String wireName = r'BalanceInquiryExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BalanceInquiryExternalRequest object, {
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
    BalanceInquiryExternalRequest object, {
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
    required BalanceInquiryExternalRequestBuilder result,
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
  BalanceInquiryExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BalanceInquiryExternalRequestBuilder();
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
