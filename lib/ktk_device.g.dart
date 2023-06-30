// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ktk_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_KTKDevice _$$_KTKDeviceFromJson(Map<String, dynamic> json) => _$_KTKDevice(
      proximityUUID: json['proximityUUID'] as String,
      major: json['major'] as String,
      macAdress: json['macAdress'] as String,
      minor: json['minor'] as int,
      updatedAt: json['updatedAt'] as int,
      rssi: json['rssi'] as String?,
      txPower: json['txPower'] as String?,
    );

Map<String, dynamic> _$$_KTKDeviceToJson(_$_KTKDevice instance) =>
    <String, dynamic>{
      'proximityUUID': instance.proximityUUID,
      'major': instance.major,
      'macAdress': instance.macAdress,
      'minor': instance.minor,
      'updatedAt': instance.updatedAt,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
