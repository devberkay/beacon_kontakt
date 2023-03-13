
import 'package:flutter/services.dart';

import 'beacon_kontakt_platform_interface.dart';

class BeaconKontakt {
  static const MethodChannel _channel = const MethodChannel('beacon_kontakt');
  
  Future<String?> getPlatformVersion() {
    return BeaconKontaktPlatform.instance.getPlatformVersion();
  }
  
}
