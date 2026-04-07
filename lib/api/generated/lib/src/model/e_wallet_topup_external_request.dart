//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'e_wallet_topup_external_request.g.dart';

/// EWalletTopupExternalRequest
///
/// Properties:
/// * [walletProvider] 
/// * [walletAccountId] 
/// * [amount] 
/// * [currency] 
/// * [idempotencyKey] 
@BuiltValue()
abstract class EWalletTopupExternalRequest implements Built<EWalletTopupExternalRequest, EWalletTopupExternalRequestBuilder> {
  @BuiltValueField(wireName: r'walletProvider')
  EWalletTopupExternalRequestWalletProviderEnum get walletProvider;
  // enum walletProviderEnum {  SARAWAK_PAY,  SARAWAK_TOPUP,  };

  @BuiltValueField(wireName: r'walletAccountId')
  String get walletAccountId;

  @BuiltValueField(wireName: r'amount')
  String get amount;

  @BuiltValueField(wireName: r'currency')
  EWalletTopupExternalRequestCurrencyEnum get currency;
  // enum currencyEnum {  MYR,  };

  @BuiltValueField(wireName: r'idempotencyKey')
  String get idempotencyKey;

  EWalletTopupExternalRequest._();

  factory EWalletTopupExternalRequest([void updates(EWalletTopupExternalRequestBuilder b)]) = _$EWalletTopupExternalRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EWalletTopupExternalRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EWalletTopupExternalRequest> get serializer => _$EWalletTopupExternalRequestSerializer();
}

class _$EWalletTopupExternalRequestSerializer implements PrimitiveSerializer<EWalletTopupExternalRequest> {
  @override
  final Iterable<Type> types = const [EWalletTopupExternalRequest, _$EWalletTopupExternalRequest];

  @override
  final String wireName = r'EWalletTopupExternalRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EWalletTopupExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'walletProvider';
    yield serializers.serialize(
      object.walletProvider,
      specifiedType: const FullType(EWalletTopupExternalRequestWalletProviderEnum),
    );
    yield r'walletAccountId';
    yield serializers.serialize(
      object.walletAccountId,
      specifiedType: const FullType(String),
    );
    yield r'amount';
    yield serializers.serialize(
      object.amount,
      specifiedType: const FullType(String),
    );
    yield r'currency';
    yield serializers.serialize(
      object.currency,
      specifiedType: const FullType(EWalletTopupExternalRequestCurrencyEnum),
    );
    yield r'idempotencyKey';
    yield serializers.serialize(
      object.idempotencyKey,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EWalletTopupExternalRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EWalletTopupExternalRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'walletProvider':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EWalletTopupExternalRequestWalletProviderEnum),
          ) as EWalletTopupExternalRequestWalletProviderEnum;
          result.walletProvider = valueDes;
          break;
        case r'walletAccountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.walletAccountId = valueDes;
          break;
        case r'amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.amount = valueDes;
          break;
        case r'currency':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EWalletTopupExternalRequestCurrencyEnum),
          ) as EWalletTopupExternalRequestCurrencyEnum;
          result.currency = valueDes;
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
  EWalletTopupExternalRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EWalletTopupExternalRequestBuilder();
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

class EWalletTopupExternalRequestWalletProviderEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'SARAWAK_PAY')
  static const EWalletTopupExternalRequestWalletProviderEnum SARAWAK_PAY = _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_PAY;
  @BuiltValueEnumConst(wireName: r'SARAWAK_TOPUP')
  static const EWalletTopupExternalRequestWalletProviderEnum SARAWAK_TOPUP = _$eWalletTopupExternalRequestWalletProviderEnum_SARAWAK_TOPUP;

  static Serializer<EWalletTopupExternalRequestWalletProviderEnum> get serializer => _$eWalletTopupExternalRequestWalletProviderEnumSerializer;

  const EWalletTopupExternalRequestWalletProviderEnum._(String name): super(name);

  static BuiltSet<EWalletTopupExternalRequestWalletProviderEnum> get values => _$eWalletTopupExternalRequestWalletProviderEnumValues;
  static EWalletTopupExternalRequestWalletProviderEnum valueOf(String name) => _$eWalletTopupExternalRequestWalletProviderEnumValueOf(name);
}

class EWalletTopupExternalRequestCurrencyEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'MYR')
  static const EWalletTopupExternalRequestCurrencyEnum MYR = _$eWalletTopupExternalRequestCurrencyEnum_MYR;

  static Serializer<EWalletTopupExternalRequestCurrencyEnum> get serializer => _$eWalletTopupExternalRequestCurrencyEnumSerializer;

  const EWalletTopupExternalRequestCurrencyEnum._(String name): super(name);

  static BuiltSet<EWalletTopupExternalRequestCurrencyEnum> get values => _$eWalletTopupExternalRequestCurrencyEnumValues;
  static EWalletTopupExternalRequestCurrencyEnum valueOf(String name) => _$eWalletTopupExternalRequestCurrencyEnumValueOf(name);
}

