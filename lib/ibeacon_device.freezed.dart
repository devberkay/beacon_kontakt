// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ibeacon_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

IBeaconDevice _$IBeaconDeviceFromJson(Map<String, dynamic> json) {
  return _IBeaconDevice.fromJson(json);
}

/// @nodoc
mixin _$IBeaconDevice {
  String get proximityUUID => throw _privateConstructorUsedError;
  String get major => throw _privateConstructorUsedError;
  int get minor => throw _privateConstructorUsedError;
  int? get proximity => throw _privateConstructorUsedError;
  String? get userId =>
      throw _privateConstructorUsedError; // this is later to be fetched from firestore
  int? get updatedAt => throw _privateConstructorUsedError; // msSinceEpoch
  String? get rssi => throw _privateConstructorUsedError;
  String? get txPower => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IBeaconDeviceCopyWith<IBeaconDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IBeaconDeviceCopyWith<$Res> {
  factory $IBeaconDeviceCopyWith(
          IBeaconDevice value, $Res Function(IBeaconDevice) then) =
      _$IBeaconDeviceCopyWithImpl<$Res, IBeaconDevice>;
  @useResult
  $Res call(
      {String proximityUUID,
      String major,
      int minor,
      int? proximity,
      String? userId,
      int? updatedAt,
      String? rssi,
      String? txPower});
}

/// @nodoc
class _$IBeaconDeviceCopyWithImpl<$Res, $Val extends IBeaconDevice>
    implements $IBeaconDeviceCopyWith<$Res> {
  _$IBeaconDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proximityUUID = null,
    Object? major = null,
    Object? minor = null,
    Object? proximity = freezed,
    Object? userId = freezed,
    Object? updatedAt = freezed,
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
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      proximity: freezed == proximity
          ? _value.proximity
          : proximity // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
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
abstract class _$$_IBeaconDeviceCopyWith<$Res>
    implements $IBeaconDeviceCopyWith<$Res> {
  factory _$$_IBeaconDeviceCopyWith(
          _$_IBeaconDevice value, $Res Function(_$_IBeaconDevice) then) =
      __$$_IBeaconDeviceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String proximityUUID,
      String major,
      int minor,
      int? proximity,
      String? userId,
      int? updatedAt,
      String? rssi,
      String? txPower});
}

/// @nodoc
class __$$_IBeaconDeviceCopyWithImpl<$Res>
    extends _$IBeaconDeviceCopyWithImpl<$Res, _$_IBeaconDevice>
    implements _$$_IBeaconDeviceCopyWith<$Res> {
  __$$_IBeaconDeviceCopyWithImpl(
      _$_IBeaconDevice _value, $Res Function(_$_IBeaconDevice) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? proximityUUID = null,
    Object? major = null,
    Object? minor = null,
    Object? proximity = freezed,
    Object? userId = freezed,
    Object? updatedAt = freezed,
    Object? rssi = freezed,
    Object? txPower = freezed,
  }) {
    return _then(_$_IBeaconDevice(
      proximityUUID: null == proximityUUID
          ? _value.proximityUUID
          : proximityUUID // ignore: cast_nullable_to_non_nullable
              as String,
      major: null == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String,
      minor: null == minor
          ? _value.minor
          : minor // ignore: cast_nullable_to_non_nullable
              as int,
      proximity: freezed == proximity
          ? _value.proximity
          : proximity // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$_IBeaconDevice with DiagnosticableTreeMixin implements _IBeaconDevice {
  const _$_IBeaconDevice(
      {required this.proximityUUID,
      required this.major,
      required this.minor,
      this.proximity,
      this.userId,
      this.updatedAt,
      this.rssi,
      this.txPower});

  factory _$_IBeaconDevice.fromJson(Map<String, dynamic> json) =>
      _$$_IBeaconDeviceFromJson(json);

  @override
  final String proximityUUID;
  @override
  final String major;
  @override
  final int minor;
  @override
  final int? proximity;
  @override
  final String? userId;
// this is later to be fetched from firestore
  @override
  final int? updatedAt;
// msSinceEpoch
  @override
  final String? rssi;
  @override
  final String? txPower;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'IBeaconDevice(proximityUUID: $proximityUUID, major: $major, minor: $minor, proximity: $proximity, userId: $userId, updatedAt: $updatedAt, rssi: $rssi, txPower: $txPower)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'IBeaconDevice'))
      ..add(DiagnosticsProperty('proximityUUID', proximityUUID))
      ..add(DiagnosticsProperty('major', major))
      ..add(DiagnosticsProperty('minor', minor))
      ..add(DiagnosticsProperty('proximity', proximity))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('rssi', rssi))
      ..add(DiagnosticsProperty('txPower', txPower));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_IBeaconDevice &&
            (identical(other.proximityUUID, proximityUUID) ||
                other.proximityUUID == proximityUUID) &&
            (identical(other.major, major) || other.major == major) &&
            (identical(other.minor, minor) || other.minor == minor) &&
            (identical(other.proximity, proximity) ||
                other.proximity == proximity) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            (identical(other.txPower, txPower) || other.txPower == txPower));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, proximityUUID, major, minor,
      proximity, userId, updatedAt, rssi, txPower);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_IBeaconDeviceCopyWith<_$_IBeaconDevice> get copyWith =>
      __$$_IBeaconDeviceCopyWithImpl<_$_IBeaconDevice>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_IBeaconDeviceToJson(
      this,
    );
  }
}

abstract class _IBeaconDevice implements IBeaconDevice {
  const factory _IBeaconDevice(
      {required final String proximityUUID,
      required final String major,
      required final int minor,
      final int? proximity,
      final String? userId,
      final int? updatedAt,
      final String? rssi,
      final String? txPower}) = _$_IBeaconDevice;

  factory _IBeaconDevice.fromJson(Map<String, dynamic> json) =
      _$_IBeaconDevice.fromJson;

  @override
  String get proximityUUID;
  @override
  String get major;
  @override
  int get minor;
  @override
  int? get proximity;
  @override
  String? get userId;
  @override // this is later to be fetched from firestore
  int? get updatedAt;
  @override // msSinceEpoch
  String? get rssi;
  @override
  String? get txPower;
  @override
  @JsonKey(ignore: true)
  _$$_IBeaconDeviceCopyWith<_$_IBeaconDevice> get copyWith =>
      throw _privateConstructorUsedError;
}
