// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'isecure_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ISecureProfile _$ISecureProfileFromJson(Map<String, dynamic> json) {
  return _ISecureProfile.fromJson(json);
}

/// @nodoc
mixin _$ISecureProfile {
  String get name => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get rssi => throw _privateConstructorUsedError;
  String get txPower => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ISecureProfileCopyWith<ISecureProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ISecureProfileCopyWith<$Res> {
  factory $ISecureProfileCopyWith(
          ISecureProfile value, $Res Function(ISecureProfile) then) =
      _$ISecureProfileCopyWithImpl<$Res, ISecureProfile>;
  @useResult
  $Res call({String name, String uid, String rssi, String txPower});
}

/// @nodoc
class _$ISecureProfileCopyWithImpl<$Res, $Val extends ISecureProfile>
    implements $ISecureProfileCopyWith<$Res> {
  _$ISecureProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
    Object? rssi = null,
    Object? txPower = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: null == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as String,
      txPower: null == txPower
          ? _value.txPower
          : txPower // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ISecureProfileCopyWith<$Res>
    implements $ISecureProfileCopyWith<$Res> {
  factory _$$_ISecureProfileCopyWith(
          _$_ISecureProfile value, $Res Function(_$_ISecureProfile) then) =
      __$$_ISecureProfileCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String uid, String rssi, String txPower});
}

/// @nodoc
class __$$_ISecureProfileCopyWithImpl<$Res>
    extends _$ISecureProfileCopyWithImpl<$Res, _$_ISecureProfile>
    implements _$$_ISecureProfileCopyWith<$Res> {
  __$$_ISecureProfileCopyWithImpl(
      _$_ISecureProfile _value, $Res Function(_$_ISecureProfile) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? uid = null,
    Object? rssi = null,
    Object? txPower = null,
  }) {
    return _then(_$_ISecureProfile(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      rssi: null == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as String,
      txPower: null == txPower
          ? _value.txPower
          : txPower // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ISecureProfile
    with DiagnosticableTreeMixin
    implements _ISecureProfile {
  const _$_ISecureProfile(
      {required this.name,
      required this.uid,
      required this.rssi,
      required this.txPower});

  factory _$_ISecureProfile.fromJson(Map<String, dynamic> json) =>
      _$$_ISecureProfileFromJson(json);

  @override
  final String name;
  @override
  final String uid;
  @override
  final String rssi;
  @override
  final String txPower;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ISecureProfile(name: $name, uid: $uid, rssi: $rssi, txPower: $txPower)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ISecureProfile'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('rssi', rssi))
      ..add(DiagnosticsProperty('txPower', txPower));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ISecureProfile &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.txPower, txPower) || other.txPower == txPower));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, uid, rssi, txPower);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ISecureProfileCopyWith<_$_ISecureProfile> get copyWith =>
      __$$_ISecureProfileCopyWithImpl<_$_ISecureProfile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ISecureProfileToJson(
      this,
    );
  }
}

abstract class _ISecureProfile implements ISecureProfile {
  const factory _ISecureProfile(
      {required final String name,
      required final String uid,
      required final String rssi,
      required final String txPower}) = _$_ISecureProfile;

  factory _ISecureProfile.fromJson(Map<String, dynamic> json) =
      _$_ISecureProfile.fromJson;

  @override
  String get name;
  @override
  String get uid;
  @override
  String get rssi;
  @override
  String get txPower;
  @override
  @JsonKey(ignore: true)
  _$$_ISecureProfileCopyWith<_$_ISecureProfile> get copyWith =>
      throw _privateConstructorUsedError;
}
