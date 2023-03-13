import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beacon_kontakt/beacon_kontakt_method_channel.dart';

void main() {
  MethodChannelBeaconKontakt platform = MethodChannelBeaconKontakt();
  const MethodChannel channel = MethodChannel('beacon_kontakt');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
