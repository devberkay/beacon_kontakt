import 'dart:convert';

class IBeaconDevice {
  final String proximityUUID;
  final String major;
  final String minor;
  final int? rssi;
  final int? txPower;
}
