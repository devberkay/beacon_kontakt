import 'package:beacon_kontakt/permission_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beacon_kontakt/beacon_kontakt.dart';
import 'package:beacon_kontakt/beacon_kontakt_platform_interface.dart';
import 'package:beacon_kontakt/beacon_kontakt_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBeaconKontaktPlatform
    with MockPlatformInterfaceMixin
    implements BeaconKontaktPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> checkPermissions() async {
    return Future.value(null);
  }

  @override
  Stream<BLEPermissionStatus> listenPermissionStatus() {
    return Stream.value(null);
  }
}

void main() {
  final BeaconKontaktPlatform initialPlatform = BeaconKontaktPlatform.instance;

  test('$MethodChannelBeaconKontakt is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBeaconKontakt>());
  });

  test('getPlatformVersion', () async {
    BeaconKontakt beaconKontaktPlugin = BeaconKontakt();
    MockBeaconKontaktPlatform fakePlatform = MockBeaconKontaktPlatform();
    BeaconKontaktPlatform.instance = fakePlatform;

    expect(await beaconKontaktPlugin.getPlatformVersion(), '42');
  });
}
