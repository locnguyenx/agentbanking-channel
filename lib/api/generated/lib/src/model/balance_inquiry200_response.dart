//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'balance_inquiry200_response.g.dart';

/// BalanceInquiry200Response
///
/// Properties:
/// * [status] 
/// * [balance] 
/// * [currency] 
/// * [accountMasked] 
/// * [responseCode] 
@BuiltValue()
abstract class BalanceInquiry200Response implements Built<BalanceInquiry200Response, BalanceInquiry200ResponseBuilder> {
  @BuiltValueField(wireName: r'status')
  String? get status;

  @BuiltValueField(wireName: r'balance')
  num? get balance;

  @BuiltValueField(wireName: r'currency')
  String? get currency;

  @BuiltValueField(wireName: r'accountMasked')
  String? get accountMasked;

  @BuiltValueField(wireName: r'responseCode')
  String? get responseCode;

  BalanceInquiry200Response._();

  factory BalanceInquiry200Response([void updates(BalanceInquiry200ResponseBuilder b)]) = _$BalanceInquiry200Response;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BalanceInquiry200ResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BalanceInquiry200Response> get serializer => _$BalanceInquiry200ResponseSerializer();
}

class _$BalanceInquiry200ResponseSerializer implements PrimitiveSerializer<BalanceInquiry200Response> {
  @override
  final Iterable<Type> types = const [BalanceInquiry200Response, _$BalanceInquiry200Response];

  @override
  final String wireName = r'BalanceInquiry200Response';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BalanceInquiry200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(String),
      );
    }
    if (object.balance != null) {
      yield r'balance';
      yield serializers.serialize(
        object.balance,
        specifiedType: const FullType(num),
      );
    }
    if (object.currency != null) {
      yield r'currency';
      yield serializers.serialize(
        object.currency,
        specifiedType: const FullType(String),
      );
    }
    if (object.accountMasked != null) {
      yield r'accountMasked';
      yield serializers.serialize(
        object.accountMasked,
        specifiedType: const FullType(String),
      );
    }
    if (object.responseCode != null) {
      yield r'responseCode';
      yield serializers.serialize(
        object.responseCode,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    BalanceInquiry200Response object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BalanceInquiry200ResponseBuilder result,
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
        case r'balance':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.balance = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.currency = valueDes;
          break;
        case r'accountMasked':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountMasked = valueDes;
          break;
        case r'responseCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.responseCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BalanceInquiry200Response deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BalanceInquiry200ResponseBuilder();
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

