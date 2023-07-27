
import 'package:beacon_kontakt/permission_enum.dart';
import 'package:flutter/services.dart';

import 'beacon_kontakt_platform_interface.dart';
import 'ibeacon_device.dart';

import 'scan_period_enum.dart';

class BeaconKontakt {
  

  Future<String?> getPlatformVersion() {
    return BeaconKontaktPlatform.instance.getPlatformVersion();
  }

  Future<bool?> checkPermissions() {
    return BeaconKontaktPlatform.instance.checkPermissions();
  }

  Future<String?> emitPermissionStatusString() async {
    return BeaconKontaktPlatform.instance.emitPermissionStatusString();
  }

  Stream<BLEPermissionStatus> listenPermissionStatus() {
    return BeaconKontaktPlatform.instance.listenPermissionStatus();
  }

  Future<void> initKontaktSDK(String apiKey) {
    return BeaconKontaktPlatform.instance.initKontaktSDK(apiKey);
  }

  Future<void> startScanning(ScanPeriod scanPeriod,  String proximityUUID, [int? major, int? minor]) { 
    return BeaconKontaktPlatform.instance.startScanning(scanPeriod,proximityUUID,major,minor);
  }

  Future<void> stopScanning() {
    return BeaconKontaktPlatform.instance.stopScanning();
  }

  Stream<List<IBeaconDevice>>  listenIBeaconsUpdated() {
    return BeaconKontaktPlatform.instance.listenIBeaconsUpdated();
  }

  Stream<IBeaconDevice> listenIBeaconLost() {
    return BeaconKontaktPlatform.instance.listenIBeaconLost();
  }

  Stream<IBeaconDevice> listenIBeaconDiscovered() {
    return BeaconKontaktPlatform.instance.listenIBeaconDiscovered();
  } 

  Future<void> openBluetoothSettings() async {
    return BeaconKontaktPlatform.instance.openBluetoothSettings();
  }

  Future<void> openLocationSettings() async {
   return BeaconKontaktPlatform.instance.openLocationSettings();
  }

  Stream<bool> listenBluetoothServiceStatus() {
    return BeaconKontaktPlatform.instance.listenBluetoothServiceStatus();
  }

  Stream<bool> listenLocationServiceStatus() {
    return BeaconKontaktPlatform.instance.listenLocationServiceStatus();
  }

  Stream<bool> listenScanStatus() {
    return BeaconKontaktPlatform.instance.listenScanStatus();
  }
 
 }
