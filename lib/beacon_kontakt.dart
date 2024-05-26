import 'package:beacon_kontakt/permission_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'beacon_kontakt_platform_interface.dart';
import 'ibeacon_device.dart';

import 'scan_period_enum.dart';

class BeaconKontakt {
  BeaconKontakt._();

  static final BeaconKontakt _instance = BeaconKontakt._();

  // Public static method to access the instance
  static BeaconKontakt get instance => _instance;

  Future<String?> getPlatformVersion() {
    return BeaconKontaktPlatform.instance.getPlatformVersion();
  }

  Future<void> initKontaktSDK(String apiKey) {
    return BeaconKontaktPlatform.instance.initKontaktSDK(apiKey);
  }

  Future<void> startScanning(ScanPeriod scanPeriod, String proximityUUID,
      [int? major, int? minor]) {
    return BeaconKontaktPlatform.instance
        .startScanning(scanPeriod, proximityUUID, major, minor);
  }

  Future<void> stopScanning() {
    return BeaconKontaktPlatform.instance.stopScanning();
  }

  Stream<List<IBeaconDevice>> listenIBeaconsUpdated() {
    return BeaconKontaktPlatform.instance.listenIBeaconsUpdated();
  }

  Stream<IBeaconDevice> listenIBeaconLost() {
    return BeaconKontaktPlatform.instance.listenIBeaconLost();
  }

  Stream<IBeaconDevice> listenIBeaconDiscovered() {
    return BeaconKontaktPlatform.instance.listenIBeaconDiscovered();
  }

}
