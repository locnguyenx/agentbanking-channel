// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_kad_verify_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyKadVerifyRequest extends MyKadVerifyRequest {
  @override
  final String mykadNumber;
  @override
  final String name;
  @override
  final Date? dateOfBirth;
  @override
  final String? address;

  factory _$MyKadVerifyRequest(
          [void Function(MyKadVerifyRequestBuilder)? updates]) =>
      (MyKadVerifyRequestBuilder()..update(updates))._build();

  _$MyKadVerifyRequest._(
      {required this.mykadNumber,
      required this.name,
      this.dateOfBirth,
      this.address})
      : super._();
  @override
  MyKadVerifyRequest rebuild(
          void Function(MyKadVerifyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyKadVerifyRequestBuilder toBuilder() =>
      MyKadVerifyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyKadVerifyRequest &&
        mykadNumber == other.mykadNumber &&
        name == other.name &&
        dateOfBirth == other.dateOfBirth &&
        address == other.address;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mykadNumber.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, dateOfBirth.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyKadVerifyRequest')
          ..add('mykadNumber', mykadNumber)
          ..add('name', name)
          ..add('dateOfBirth', dateOfBirth)
          ..add('address', address))
        .toString();
  }
}

class MyKadVerifyRequestBuilder
    implements Builder<MyKadVerifyRequest, MyKadVerifyRequestBuilder> {
  _$MyKadVerifyRequest? _$v;

  String? _mykadNumber;
  String? get mykadNumber => _$this._mykadNumber;
  set mykadNumber(String? mykadNumber) => _$this._mykadNumber = mykadNumber;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  Date? _dateOfBirth;
  Date? get dateOfBirth => _$this._dateOfBirth;
  set dateOfBirth(Date? dateOfBirth) => _$this._dateOfBirth = dateOfBirth;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  MyKadVerifyRequestBuilder() {
    MyKadVerifyRequest._defaults(this);
  }

  MyKadVerifyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mykadNumber = $v.mykadNumber;
      _name = $v.name;
      _dateOfBirth = $v.dateOfBirth;
      _address = $v.address;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyKadVerifyRequest other) {
    _$v = other as _$MyKadVerifyRequest;
  }

  @override
  void update(void Function(MyKadVerifyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyKadVerifyRequest build() => _build();

  _$MyKadVerifyRequest _build() {
    final _$result = _$v ??
        _$MyKadVerifyRequest._(
          mykadNumber: BuiltValueNullFieldError.checkNotNull(
              mykadNumber, r'MyKadVerifyRequest', 'mykadNumber'),
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'MyKadVerifyRequest', 'name'),
          dateOfBirth: dateOfBirth,
          address: address,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
