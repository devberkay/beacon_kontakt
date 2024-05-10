// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibeacon_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IBeaconDeviceImpl _$$IBeaconDeviceImplFromJson(Map<String, dynamic> json) =>
    _$IBeaconDeviceImpl(
      proximityUUID: json['proximityUUID'] as String?,
      major: json['major'] as int?,
      minor: json['minor'] as int?,
      userId: json['userId'] as String?,
      uniqueId: json['uniqueId'] as String?,
      mac: json['mac'] as String?,
      proximity: json['proximity'] as int?,
      timestamp: json['timestamp'] as int?,
      rssi: json['rssi'] as int?,
      txPower: json['txPower'] as int?,
    );

Map<String, dynamic> _$$IBeaconDeviceImplToJson(_$IBeaconDeviceImpl instance) =>
    <String, dynamic>{
      'proximityUUID': instance.proximityUUID,
      'major': instance.major,
      'minor': instance.minor,
      'userId': instance.userId,
      'uniqueId': instance.uniqueId,
      'mac': instance.mac,
      'proximity': instance.proximity,
      'timestamp': instance.timestamp,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
