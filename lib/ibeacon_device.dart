import 'dart:convert';

class IBeaconDevice {
  final String proximityUUID;
  final String major;
  final String minor;
  final int? rssi; // doesn't received on monitoring
  final int? txPower; // doesn't received on monitoring
}
