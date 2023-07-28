import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:beacon_kontakt/ibeacon_device.dart';
import 'package:beacon_kontakt/scan_period_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'beacon_kontakt_platform_interface.dart';

import 'permission_enum.dart';

/// An implementation of [BeaconKontaktPlatform] that uses method channels.
class MethodChannelBeaconKontakt extends BeaconKontaktPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('beacon_kontakt');

  final activityLocationEventChannel =
      const EventChannel('beacon_kontakt_activity_location_event');
  final permissionEventChannel =
      const EventChannel('beacon_kontakt_permission_event');
  final foregroundScanStatusEventChannel =
      const EventChannel("beacon_kontakt_foreground_scan_status_event");
  final foregroundScanIBeaconsUpdatedEventChannel = const EventChannel(
      "beacon_kontakt_foreground_scan_ibeacons_updated_event");
  final foregroundScanIBeaconDiscoveredEventChannel = const EventChannel(
      "beacon_kontakt_foreground_scan_ibeacon_discovered_event");
  final foregroundScanIBeaconLostEventChannel =
      const EventChannel("beacon_kontakt_foreground_scan_ibeacon_lost_event");
  final foregroundScanSecureProfilesUpdatedEventChannel = const EventChannel(
      "beacon_kontakt_foreground_scan_secure_profiles_updated_event");
  final foregroundScanSecureProfileDiscoveredEventChannel = const EventChannel(
      "beacon_kontakt_foreground_scan_secure_profile_discovered_event");
  final foregroundScanSecureProfileLostEventChannel = const EventChannel(
      "beacon_kontakt_foreground_scan_secure_profile_lost_event");

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<bool?> checkPermissions() {
    return methodChannel.invokeMethod<bool>('checkPermissions');
  }

  @override
  Future<String?> emitPermissionStatusString() async {
    //ios-only
    //ios-only
    if (Platform.isIOS) {
      return methodChannel.invokeMethod<String>('emitPermissionStatusString');
    }
    return null;
  }

  @override
  Stream<BLEPermissionStatus> listenPermissionStatus() async* {
    try {
      await for (final status in permissionEventChannel
          .receiveBroadcastStream()
          .map((status) => status as bool
              ? BLEPermissionStatus.granted
              : BLEPermissionStatus.denied)) {
        yield status;
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
      yield BLEPermissionStatus.denied;
    }
  }

  @override
  Future<void> initKontaktSDK(String apiKey) async {
    await methodChannel
        .invokeMethod<void>('initKontaktSDK', {'apiKey': apiKey});
  }

  @override
  Future<void> startScanning(ScanPeriod scanPeriod, String proximityUUID,
      [int? major, int? minor]) async {
    await methodChannel.invokeMethod<void>('startScanning', {
      "scanPeriod":
          scanPeriod == ScanPeriod.monitoring ? "Monitoring" : "Ranging",
      "proximityUUID": proximityUUID,
      "major": major,
      "minor": minor,
    });
  }

  @override
  Future<void> stopScanning() async {
    await methodChannel.invokeMethod<void>('stopScanning');
  }

  @override
  Stream<List<IBeaconDevice>> listenIBeaconsUpdated() async* {
    try {
      await for (final List<Object?> listOfDevices
          in foregroundScanIBeaconsUpdatedEventChannel
              .receiveBroadcastStream("iBeaconsUpdatedEventSink")) {
        debugPrint("updatedList : $listOfDevices");
        final listOfIBeaconsAsMap = listOfDevices
            .map((e) => jsonDecode(jsonEncode(e)) as Map<String, dynamic>)
            .toList();

        yield listOfIBeaconsAsMap
            .map((e) => IBeaconDevice.fromJson(e))
            .toList();
      }
    } on PlatformException catch (e) {
      debugPrint("listenIBeaconsUpdated Error : ${e.message}");
    }
  }

  @override
  Stream<IBeaconDevice> listenIBeaconLost() async* {
    try {
      await for (final Object? device in foregroundScanIBeaconLostEventChannel
          .receiveBroadcastStream("iBeaconLostEventSink")) {
        final iBeaconAsMap =
            jsonDecode(jsonEncode(device)) as Map<String, dynamic>;
        debugPrint("lost : $device");
        yield IBeaconDevice.fromJson(iBeaconAsMap);
      }
    } on PlatformException catch (e) {
      debugPrint("listenIBeaconLost Error : ${e.message}");
    }
  }

  @override
  Stream<IBeaconDevice> listenIBeaconDiscovered() async* {
    try {
      await for (final Object? device
          in foregroundScanIBeaconDiscoveredEventChannel
              .receiveBroadcastStream("iBeaconDiscoveredEventSink")) {
        debugPrint("discovered : $device");
        final iBeaconAsMap =
            jsonDecode(jsonEncode(device)) as Map<String, dynamic>;

        yield IBeaconDevice.fromJson(iBeaconAsMap);
      }
    } on PlatformException catch (e) {
      debugPrint("listenIBeaconDiscovered Error : ${e.message}");
    }
  }

  @override
  Stream<bool> listenLocationServiceStatus() async* {
    if (Platform.isAndroid) {
      while (true) {
        yield await methodChannel.invokeMethod<bool>("emitLocationStatus") ??
            false;
        // await Future.delayed(const Duration(milliseconds: 500));
      }
    } else if (Platform.isIOS) {
      try {
        await for (final currentStatus
            in activityLocationEventChannel.receiveBroadcastStream()) {
          yield currentStatus as bool? ?? false;
        }
      } on PlatformException catch (e) {
        debugPrint("listenScanStatus : ${e.message}");
      }
    }
  }

  @override
  Stream<bool> listenBluetoothServiceStatus() async* {
    while (true) {
      yield await methodChannel.invokeMethod<bool>("emitBluetoothStatus") ??
          false;
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  @override
  Future<void> openBluetoothSettings() async {
    await methodChannel.invokeMethod("openBluetoothSettings");
  }

  @override
  Future<void> openLocationSettings() async {
    await methodChannel.invokeMethod("openLocationSettings");
  }

  @override
  Stream<bool> listenScanStatus() async* {
    try {
      await for (final currentStatus in foregroundScanStatusEventChannel
          .receiveBroadcastStream("statusEventSink")) {
        yield currentStatus as bool;
      }
    } on PlatformException catch (e) {
      debugPrint("listenScanStatus : ${e.message}");
    }
  }
}
