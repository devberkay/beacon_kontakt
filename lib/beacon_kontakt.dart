
import 'beacon_kontakt_platform_interface.dart';

class BeaconKontakt {
  Future<String?> getPlatformVersion() {
    return BeaconKontaktPlatform.instance.getPlatformVersion();
  }
}
