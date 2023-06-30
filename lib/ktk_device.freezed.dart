// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ktk_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

KTKDevice _$KTKDeviceFromJson(Map<String, dynamic> json) {
  return _KTKDevice.fromJson(json);
}

/// @nodoc
mixin _$KTKDevice {
  String get proximityUUID => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  String get macAdress => throw _privateConstructorUsedError;
  int get minor => throw _privateConstructorUsedError;
  int get updatedAt => throw _privateConstructorUsedError; // msSinceEpoch
  String? get rssi => throw _privateConstructorUsedError;
  String? get txPower => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KTKDeviceCopyWith<KTKDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KTKDeviceCopyWith<$Res> {
  factory $KTKDeviceCopyWith(KTKDevice value, $Res Function(KTKDevice) then) =
      _$KTKDeviceCopyWithImpl<$Res, KTKDevice>;
  @useResult
  $Res call(
      {String proximityUUID,
      String major,
      String macAdress,
      int minor,
      int updatedAt,
      String? rssi,
      String? txPower});
}

/// @nodoc
class _$KTKDeviceCopyWithImpl<$Res, $Val extends KTKDevice>
    implements $KTKDeviceCopyWith<$Res> {
  _$KTKDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proximityUUID = null,
    Object? major = null,
    Object? macAdress = null,
    Object? minor = null,
    Object? updatedAt = null,
    Object? rssi = freezed,
    Object? txPower = freezed,
  }) {
    return _then(_value.copyWith(
      proximityUUID: null == proximityUUID
          ? _value.proximityUUID
          : proximityUUID // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      macAdress: null == macAdress
          ? _value.macAdress
          : macAdress // ignore: cast_nullable_to_non_nullable
              as String,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int,
      rssi: freezed == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as String?,
      txPower: freezed == txPower
          ? _value.txPower
          : txPower // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_KTKDeviceCopyWith<$Res> implements $KTKDeviceCopyWith<$Res> {
  factory _$$_KTKDeviceCopyWith(
          _$_KTKDevice value, $Res Function(_$_KTKDevice) then) =
      __$$_KTKDeviceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String proximityUUID,
      String major,
      String macAdress,
      int minor,
      int updatedAt,
      String? rssi,
      String? txPower});
}

/// @nodoc
class __$$_KTKDeviceCopyWithImpl<$Res>
    extends _$KTKDeviceCopyWithImpl<$Res, _$_KTKDevice>
    implements _$$_KTKDeviceCopyWith<$Res> {
  __$$_KTKDeviceCopyWithImpl(
      _$_KTKDevice _value, $Res Function(_$_KTKDevice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proximityUUID = null,
    Object? major = null,
    Object? macAdress = null,
    Object? minor = null,
    Object? updatedAt = null,
    Object? rssi = freezed,
    Object? txPower = freezed,
  }) {
    return _then(_$_KTKDevice(
      proximityUUID: null == proximityUUID
          ? _value.proximityUUID
          : proximityUUID // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      macAdress: null == macAdress
          ? _value.macAdress
          : macAdress // ignore: cast_nullable_to_non_nullable
              as String,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int,
      rssi: freezed == rssi
          ? _value.rssi
          : rssi // ignore: cast_nullable_to_non_nullable
              as String?,
      txPower: freezed == txPower
          ? _value.txPower
          : txPower // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_KTKDevice with DiagnosticableTreeMixin implements _KTKDevice {
  const _$_KTKDevice(
      {required this.proximityUUID,
      required this.major,
      required this.macAdress,
      required this.minor,
      required this.updatedAt,
      this.rssi,
      this.txPower});

  factory _$_KTKDevice.fromJson(Map<String, dynamic> json) =>
      _$$_KTKDeviceFromJson(json);

  @override
  final String proximityUUID;
  @override
  final String major;
  @override
  final String macAdress;
  @override
  final int minor;
  @override
  final int updatedAt;
// msSinceEpoch
  @override
  final String? rssi;
  @override
  final String? txPower;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'KTKDevice(proximityUUID: $proximityUUID, major: $major, macAdress: $macAdress, minor: $minor, updatedAt: $updatedAt, rssi: $rssi, txPower: $txPower)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'KTKDevice'))
      ..add(DiagnosticsProperty('proximityUUID', proximityUUID))
      ..add(DiagnosticsProperty('major', major))
      ..add(DiagnosticsProperty('macAdress', macAdress))
      ..add(DiagnosticsProperty('minor', minor))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('rssi', rssi))
      ..add(DiagnosticsProperty('txPower', txPower));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_KTKDevice &&
            (identical(other.proximityUUID, proximityUUID) ||
                other.proximityUUID == proximityUUID) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.macAdress, macAdress) ||
                other.macAdress == macAdress) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.txPower, txPower) || other.txPower == txPower));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, proximityUUID, major, macAdress,
      minor, updatedAt, rssi, txPower);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_KTKDeviceCopyWith<_$_KTKDevice> get copyWith =>
      __$$_KTKDeviceCopyWithImpl<_$_KTKDevice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_KTKDeviceToJson(
      this,
    );
  }
}

abstract class _KTKDevice implements KTKDevice {
  const factory _KTKDevice(
      {required final String proximityUUID,
      required final String major,
      required final String macAdress,
      required final int minor,
      required final int updatedAt,
      final String? rssi,
      final String? txPower}) = _$_KTKDevice;

  factory _KTKDevice.fromJson(Map<String, dynamic> json) =
      _$_KTKDevice.fromJson;

  @override
  String get proximityUUID;
  @override
  String get major;
  @override
  String get macAdress;
  @override
  int get minor;
  @override
  int get updatedAt;
  @override // msSinceEpoch
  String? get rssi;
  @override
  String? get txPower;
  @override
  @JsonKey(ignore: true)
  _$$_KTKDeviceCopyWith<_$_KTKDevice> get copyWith =>
      throw _privateConstructorUsedError;
}
