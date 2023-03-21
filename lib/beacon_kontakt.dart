
import 'package:beacon_kontakt/permission_enum.dart';
import 'package:flutter/services.dart';

import 'beacon_kontakt_platform_interface.dart';
import 'listener_type_enum.dart';
import 'scan_period_enum.dart';

class BeaconKontakt {
  

  Future<String?> getPlatformVersion() {
    return BeaconKontaktPlatform.instance.getPlatformVersion();
  }

  Future<void> checkPermissions() {
    return BeaconKontaktPlatform.instance.checkPermissions();
  }

  Stream<BLEPermissionStatus> listenPermissionStatus() {
    return BeaconKontaktPlatform.instance.listenPermissionStatus();
  }

  Future<void> initKontaktSDK(String apiKey) {
    return BeaconKontaktPlatform.instance.initKontaktSDK(apiKey);
  }

  Future<void> startScanning(ScanPeriod scanPeriod, ListenerType listenerType, String proximityUUID, [int? major, int? minor]) {
    return BeaconKontaktPlatform.instance.startScanning(scanPeriod,listenerType,proximityUUID,major,minor);
  }

  Future<void> stopScanning() {
    return BeaconKontaktPlatform.instance.stopScanning();
  }

  Stream<List<Map<String, dynamic>>>  listenScanResults() {
    return BeaconKontaktPlatform.instance.listenScanResults();
  }



  
  
}
