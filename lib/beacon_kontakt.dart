
import 'package:beacon_kontakt/permission_enum.dart';
import 'package:flutter/services.dart';

import 'beacon_kontakt_platform_interface.dart';

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

  Future<void> startScanning() {
    return BeaconKontaktPlatform.instance.startScanning();
  }

  Future<void> listenScanResults() {
    
  }



  
  
}
