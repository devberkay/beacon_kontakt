class SecureProfile {
  final int rssi;
  final int txPower;
  final int batteryLevel;
  final String name;
  final String instanceId;
  final String macAddress;

  SecureProfile({
    required this.rssi,
    required this.txPower,
    required this.batteryLevel,
    required this.name,
    required this.instanceId,
    required this.macAddress,
  });

  factory SecureProfile.fromJson(Map<String, dynamic> json) {
    return SecureProfile(
      rssi: json['rssi'] as int,
      txPower: json['txPower'] as int,
      batteryLevel: json['batteryLevel'] as int,
      name: json['name'] as String,
      instanceId: json['instanceId'] as String,
      macAddress: json['macAddress'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rssi': rssi,
      'txPower': txPower,
      'batteryLevel': batteryLevel,
      'name': name,
      'instanceId': instanceId,
      'macAddress': macAddress,
    };
  }
}
