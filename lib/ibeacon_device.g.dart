// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibeacon_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IBeaconDevice _$$_IBeaconDeviceFromJson(Map<String, dynamic> json) =>
    _$_IBeaconDevice(
      proximityUUID: json['proximityUUID'] as String,
      major: json['major'] as String,
      minor: json['minor'] as int,
      proximity: json['proximity'] as int,
      userId: json['userId'] as String?,
      updatedAt: json['updatedAt'] as int?,
      rssi: json['rssi'] as String?,
      txPower: json['txPower'] as String?,
    );

Map<String, dynamic> _$$_IBeaconDeviceToJson(_$_IBeaconDevice instance) =>
    <String, dynamic>{
      'proximityUUID': instance.proximityUUID,
      'major': instance.major,
      'minor': instance.minor,
      'proximity': instance.proximity,
      'userId': instance.userId,
      'updatedAt': instance.updatedAt,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
