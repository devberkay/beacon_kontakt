import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'beacon_kontakt_method_channel.dart';

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
}
