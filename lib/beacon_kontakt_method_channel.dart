import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'beacon_kontakt_platform_interface.dart';
/// An implementation of [BeaconKontaktPlatform] that uses method channels.
class MethodChannelBeaconKontakt extends BeaconKontaktPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('beacon_kontakt');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
