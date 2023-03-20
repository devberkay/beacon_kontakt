import 'package:beacon_kontakt/scan_period_enum.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'beacon_kontakt_platform_interface.dart';
import 'listener_type_enum.dart';
import 'permission_enum.dart';

/// An implementation of [BeaconKontaktPlatform] that uses method channels.
class MethodChannelBeaconKontakt extends BeaconKontaktPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('beacon_kontakt');

  final permissionEventChannel =
      const EventChannel('beacon_kontakt_permission_event');
  final foregroundScanEventChannel =
      const EventChannel("beacon_kontakt_foreground_scan_event");

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> checkPermissions() {
    return methodChannel.invokeMethod('checkPermissions');
  }

  @override
  Stream<BLEPermissionStatus> listenPermissionStatus() async* {
    try {
      await for (final status in permissionEventChannel
          .receiveBroadcastStream()
          .map((status) => status == "PERMISSION_GRANTED"
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
  Future<void> startScanning(
      ScanPeriod scanPeriod, ListenerType listenerType) async {
    await methodChannel.invokeMethod<void>('startScanning', {
      "scanPeriod":
          scanPeriod == ScanPeriod.monitoring ? "Monitoring" : "Ranging",
      "listenerType": listenerType == ListenerType.SecureProfile
          ? "SecureProfile"
          : "iBeacon"
    });
  }

  @override
  Stream<Map<String, dynamic>> listenScanResults() async* {
    try {
      await for (final listOfDevices
          in foregroundScanEventChannel.receiveBroadcastStream()) {
       
        yield listOfDevices as Map<String, dynamic>;
      }
    } on PlatformException catch (e) {
      debugPrint(e.message);
    }
  }
}
