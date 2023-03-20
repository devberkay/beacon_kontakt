import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'beacon_kontakt_platform_interface.dart';

/// An implementation of [BeaconKontaktPlatform] that uses method channels.
class MethodChannelBeaconKontakt extends BeaconKontaktPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('beacon_kontakt');

  final permissionEventChannel = const EventChannel('beacon_kontakt_permission_event');
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
  Stream<String?> listenPermissionStatus() {
    
  }


}
