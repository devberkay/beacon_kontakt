import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'beacon_kontakt_method_channel.dart';
import 'listener_type_enum.dart';
import 'permission_enum.dart';
import 'scan_period_enum.dart';

abstract class BeaconKontaktPlatform extends PlatformInterface {
  /// Constructs a BeaconKontaktPlatform.
  BeaconKontaktPlatform() : super(token: _token);

  static final Object _token = Object();

  static BeaconKontaktPlatform _instance = MethodChannelBeaconKontakt();

  /// The default instance of [BeaconKontaktPlatform] to use.
  ///
  /// Defaults to [MethodChannelBeaconKontakt].
  static BeaconKontaktPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BeaconKontaktPlatform] when
  /// they register themselves.
  static set instance(BeaconKontaktPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> checkPermissions() {
    throw UnimplementedError('checkPermissions() has not been implemented.');
  }
  Stream<BLEPermissionStatus> listenPermissionStatus() {
    throw UnimplementedError('onPermissionChanged() has not been implemented.');
  }


  Future<void> initKontaktSDK(String apiKey) {
    throw UnimplementedError('initKontaktSDK() has not been implemented.');
  }

  Future<void> startScanning(ScanPeriod scanPeriod,ListenerType listenerType) {
    throw UnimplementedError('startScanning() has not been implemented.');
  }

  Stream<Map<String,dynamic>>  listenScanResults() {
    throw UnimplementedError('listenScanResults() has not been implemented.');
  }
}
