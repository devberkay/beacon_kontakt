// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isecure_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ISecureProfile _$$_ISecureProfileFromJson(Map<String, dynamic> json) =>
    _$_ISecureProfile(
      name: json['name'] as String,
      uid: json['uid'] as String,
      rssi: json['rssi'] as String,
      txPower: json['txPower'] as String,
    );

Map<String, dynamic> _$$_ISecureProfileToJson(_$_ISecureProfile instance) =>
    <String, dynamic>{
      'name': instance.name,
      'uid': instance.uid,
      'rssi': instance.rssi,
      'txPower': instance.txPower,
    };
