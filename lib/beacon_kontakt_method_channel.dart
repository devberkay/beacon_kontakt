import 'dart:convert';
import 'dart:io';

import 'package:beacon_kontakt/ibeacon_device.dart';
import 'package:beacon_kontakt/scan_period_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'beacon_kontakt_platform_interface.dart';

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
    // da poet
    try {
      //   debugPrint(
      //       "listenIBeaconsUpdated event: $foregroundScanIBeaconsUpdatedEventChannel");

      // final streamGroup = StreamGroup<dynamic>();

      // streamGroup.add(foregroundScanIBeaconsUpdatedEventChannel
      //     .receiveBroadcastStream("secureProfilesUpdatedEventSink"));
      // streamGroup.add(foregroundScanIBeaconsUpdatedEventChannel
      //     .receiveBroadcastStream("iBeaconsUpdatedEventSink"));

      // final combinedStream = streamGroup.stream;

      //secureProfilesUpdatedEventSink - works on android
      //iBeaconsUpdatedEventSink

      await for (final List<Object?> listOfDevices in Platform.isIOS
          ? foregroundScanIBeaconsUpdatedEventChannel
              .receiveBroadcastStream("iBeaconsUpdatedEventSink")
          : foregroundScanIBeaconsUpdatedEventChannel
              .receiveBroadcastStream("iBeaconsUpdatedEventSink")) {
        // debugPrint("listOfDevices: $listOfDevices");

        try {
          final listOfIBeaconsAsMap = listOfDevices
              .map((e) => jsonDecode(jsonEncode(e)) as Map<String, dynamic>)
              .toList();

          // debugPrint("listenIBeaconsUpdated: $listOfIBeaconsAsMap");
          yield listOfIBeaconsAsMap
              .map((e) => IBeaconDevice.fromJson(e))
              .toList();
        } catch (e) {
          debugPrint("Error processing listOfDevices: $e");
        }
      }
      // debugPrint("listOfDevices looped");
    }
    // on PlatformException catch (e) {
    //   debugPrint("listenIBeaconsUpdated Error: ${e.message}");
    // }
    on Exception catch (e) {
      debugPrint("listenIBeaconsUpdated Error: ${e.toString()}");
    }
    debugPrint("listOfDevices finished");
  }

  @override
  Stream<IBeaconDevice> listenIBeaconLost() async* {
    try {
      //iBeaconLostEventSink
      await for (final Object? device in Platform.isIOS
          ? foregroundScanIBeaconLostEventChannel
              .receiveBroadcastStream("iBeaconLostEventSink")
          : foregroundScanIBeaconLostEventChannel
              .receiveBroadcastStream("secureProfileLostEventSink")) {
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
      //secureProfileDiscoveredEventSink
      await for (final Object? device in Platform.isIOS
          ? foregroundScanIBeaconDiscoveredEventChannel
              .receiveBroadcastStream("iBeaconDiscoveredEventSink")
          : foregroundScanIBeaconDiscoveredEventChannel
              .receiveBroadcastStream("secureProfileDiscoveredEventSink")) {
        debugPrint("discovered : $device");
        final iBeaconAsMap =
            jsonDecode(jsonEncode(device)) as Map<String, dynamic>;

        yield IBeaconDevice.fromJson(iBeaconAsMap);
      }
    } on PlatformException catch (e) {
      debugPrint("listenIBeaconDiscovered Error : ${e.message}");
    }
  }
}
//new permission flow added