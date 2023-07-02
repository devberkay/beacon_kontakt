import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'beacon_kontakt_method_channel.dart';
import 'ibeacon_device.dart';

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

  Future<String?> emitPermissionStatusString() {
    throw UnimplementedError('emitPermissionStatusString() has not been implemented.');
  }

  Stream<BLEPermissionStatus> listenPermissionStatus() {
    throw UnimplementedError('onPermissionChanged() has not been implemented.');
  }


  Future<void> initKontaktSDK(String apiKey) {
    throw UnimplementedError('initKontaktSDK() has not been implemented.');
  }

  Future<void> startScanning(ScanPeriod scanPeriod,  String proximityUUID, [int? major, int? minor,List<Map<String,int>>? monitoringRegions]) {
    throw UnimplementedError('startScanning() has not been implemented.');
  }
  Future<void> stopScanning() {
    throw UnimplementedError('stopScanning() has not been implemented.');
  }

  Stream<List<IBeaconDevice>>  listenIBeaconsUpdated() {
    throw UnimplementedError('listenScanResults() has not been implemented.');
  }

  Stream<IBeaconDevice> listenIBeaconLost() {
    throw UnimplementedError('listenScanResults() has not been implemented.');
  }

  Stream<IBeaconDevice> listenIBeaconDiscovered() {
    throw UnimplementedError('listenScanResults() has not been implemented.');
  }

  Stream<bool> listenLocationServiceStatus() {
    throw UnimplementedError('listenLocationServiceStatus() has not been implemented.');
  }
  Stream<bool> listenBluetoothServiceStatus() {
    throw UnimplementedError('listenBluetoothServiceStatus() has not been implemented.');
  }
  Future<void> openLocationSettings() {
    throw UnimplementedError('openLocationSettings() has not been implemented.');
  }
  Future<void> openBluetoothSettings() {
    throw UnimplementedError('openBluetoothSettings() has not been implemented.');
  }

  Stream<bool> listenScanStatus() {
    throw UnimplementedError('isScanning() has not been implemented.');
  }
}
