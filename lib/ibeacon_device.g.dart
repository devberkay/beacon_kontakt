// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibeacon_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_IBeaconDevice _$$_IBeaconDeviceFromJson(Map<String, dynamic> json) =>
    _$_IBeaconDevice(
      proximityUUID: json['proximityUUID'] as String,
      major: json['major'] as int,
      minor: json['minor'] as int,
      payload: json['payload'] as Map<String, dynamic>?,
      userId: json['userId'] as String?,
      uniqueId: json['uniqueId'] as String?,
      proximity: json['proximity'] as int?,
      timestamp: json['timestamp'] as int?,
      rssi: json['rssi'] as int?,
      txPower: json['txPower'] as String?,
    );

Map<String, dynamic> _$$_IBeaconDeviceToJson(_$_IBeaconDevice instance) =>
    <String, dynamic>{
      'proximityUUID': instance.proximityUUID,
      'major': instance.major,
      'minor': instance.minor,
      'payload': instance.payload,
      'userId': instance.userId,
      'uniqueId': instance.uniqueId,
      'proximity': instance.proximity,
      'timestamp': instance.timestamp,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
