import 'dart:convert';

class IBeaconDevice {
  final String? proximityUUID;
  final int? major;
  final int? minor;
  final int? rssi;
  final int? txPower;
  final int? batteryLevel;
  final int? timestamp; //msSinceEpoch
  final String? name;
  final String? uniqueId;
  IBeaconDevice({
    required this.proximityUUID,
    required this.major,
    required this.minor,
    required this.rssi,
    required this.txPower,
    required this.batteryLevel,
    required this.timestamp,
    this.name,
    this.uniqueId,
  });

  IBeaconDevice copyWith({
    String? proximityUUID,
    int? major,
    int? minor,
    int? rssi,
    int? txPower,
    int? batteryLevel,
    int? timestamp,
    String? name,
    String? uniqueId,
  }) {
    return IBeaconDevice(
      proximityUUID: proximityUUID ?? this.proximityUUID,
      major: major ?? this.major,
      minor: minor ?? this.minor,
      rssi: rssi ?? this.rssi,
      txPower: txPower ?? this.txPower,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      timestamp: timestamp ?? this.timestamp,
      name: name ?? this.name,
      uniqueId: uniqueId ?? this.uniqueId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'proximityUUID': proximityUUID,
      'major': major,
      'minor': minor,
      'rssi': rssi,
      'txPower': txPower,
      'batteryLevel': batteryLevel,
      'timestamp': timestamp,
      'name': name,
      'uniqueId': uniqueId,
    };
  }

  factory IBeaconDevice.fromMap(Map<String, dynamic> map) {
    return IBeaconDevice(
      proximityUUID: map['proximityUUID'],
      major: map['major']?.toInt(),
      minor: map['minor']?.toInt(),
      rssi: map['rssi']?.toInt(),
      txPower: map['txPower']?.toInt(),
      batteryLevel: map['batteryLevel']?.toInt(),
      timestamp: map['timestamp']?.toInt(),
      name: map['name'],
      uniqueId: map['uniqueId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IBeaconDevice.fromJson(String source) => IBeaconDevice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IBeaconDevice(proximityUUID: $proximityUUID, major: $major, minor: $minor, rssi: $rssi, txPower: $txPower, batteryLevel: $batteryLevel, timestamp: $timestamp, name: $name, uniqueId: $uniqueId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is IBeaconDevice &&
      other.proximityUUID == proximityUUID &&
      other.major == major &&
      other.minor == minor &&
      other.rssi == rssi &&
      other.txPower == txPower &&
      other.batteryLevel == batteryLevel &&
      other.timestamp == timestamp &&
      other.name == name &&
      other.uniqueId == uniqueId;
  }

  @override
  int get hashCode {
    return proximityUUID.hashCode ^
      major.hashCode ^
      minor.hashCode ^
      rssi.hashCode ^
      txPower.hashCode ^
      batteryLevel.hashCode ^
      timestamp.hashCode ^
      name.hashCode ^
      uniqueId.hashCode;
  }
}
