import 'package:beacon_kontakt/ibeacon_device.dart';

import 'package:beacon_kontakt/permission_enum.dart';
import 'package:beacon_kontakt/scan_period_enum.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:beacon_kontakt/beacon_kontakt.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final beaconKontaktApiProvider = Provider<BeaconKontakt>((ref) {
  return BeaconKontakt();
});

final isScanningProvider = StreamProvider.autoDispose<bool>((ref) async* {
  final beaconKontaktApi = ref.watch(beaconKontaktApiProvider);
  await for (bool currentStatus in beaconKontaktApi.listenScanStatus()) {
    yield currentStatus;
  }
});

// final isBluetoothOpenProvider = StreamProvider<bool>((ref) async* {
//   final beaconKontaktApi = ref.watch(beaconKontaktApiProvider);
//   await for (bool currentStatus
//       in beaconKontaktApi.listenBluetoothServiceStatus()) {
//     yield currentStatus;
//   }
// });

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatefulHookConsumerWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String _platformVersion = 'Unknown';
  late final BeaconKontakt _beaconKontaktPlugin;
  late final StreamSubscription permissionStatusStreamSubscription;

  @override
  void initState() {
    _beaconKontaktPlugin = ref.read(beaconKontaktApiProvider);
    super.initState();
    initPlatformState();
    initKontaktSDK();
  }

  @override
  void dispose() {
    permissionStatusStreamSubscription.cancel();
    super.dispose();
  }

  Future<void> initKontaktSDK() async {
    await _beaconKontaktPlugin
        .initKontaktSDK("dgSRGSjPdKlgymeNiratRYxucDqGOCtj");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _beaconKontaktPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> checkPermissions() async {
    await _beaconKontaktPlugin.checkPermissions();

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    final isScanning = ref.watch(isScanningProvider).when(data: (value) {
      print("isScanning : $value");
      return value;
    }, error: (e, st) {
      print("Funcking error : $e");
      return false;
    }, loading: () {
      print("isScanning : Loading");
      return false;
    });

    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.search),
            onPressed: () async {
              await checkPermissions();
            }),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              StreamBuilder<BLEPermissionStatus>(
                  initialData: BLEPermissionStatus.denied,
                  stream: _beaconKontaktPlugin.listenPermissionStatus(),
                  builder: (context, snapshot) {
                    final permissionStatus =
                        snapshot.data ?? BLEPermissionStatus.denied;
                    return Text('Permissions are ${permissionStatus.name}');
                  }),
              TextButton(
                  onPressed: () async {
                    await _beaconKontaktPlugin.startScanning(
                        ScanPeriod.monitoring,
                        'F7826DA6-4FA2-4E98-8024-BC5B71E0893E',
                        -1,
                        -1, 
                        );
                  },
                  child: const Text("Start Scanning")),
              TextButton(
                  onPressed: () async {
                    await _beaconKontaktPlugin.openLocationSettings();
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Text("Open Location Service settings")),
              TextButton(
                  onPressed: () async {
                    await _beaconKontaktPlugin.openBluetoothSettings();
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  child: const Text("Open Bluetooth settings")),
              TextButton(
                  onPressed: () async {
                    await _beaconKontaktPlugin.stopScanning();

                    // _beaconKontaktPlugin.listenScanResults().listen((event) {
                    //   print(event);
                    // });
                  },
                  child: const Text(
                    "Stop Scanning",
                    style: TextStyle(color: Colors.red),
                  )),
              if (isScanning)
                StreamBuilder<IBeaconDevice>(
                    stream: _beaconKontaktPlugin.listenIBeaconDiscovered(),
                    builder: (context, snapshot) {
                      final discoveredDevice = snapshot.data;

                      return SizedBox(
                        height: 100,
                        child: ListView(
                          children: [
                            const Text(
                              "IBeaconsDiscovered Device List : ",
                              textAlign: TextAlign.center,
                            ),
                            if (discoveredDevice != null)
                              Card(child: Text(discoveredDevice.toString()))
                          ],
                        ),
                      );
                    }),
              const SizedBox(
                height: 20,
              ),
              if (isScanning)
                StreamBuilder<List<IBeaconDevice>>(
                    stream: _beaconKontaktPlugin.listenIBeaconsUpdated(),
                    builder: (context, snapshot) {
                      final scanResults = snapshot.data ?? [];
                      debugPrint("scanResults : $scanResults");
                      return SizedBox(
                        height: 200,
                        child: ListView(
                          children: [
                            const Text(
                              "IBeaconsUpdated Device List : ",
                              textAlign: TextAlign.center,
                            ),
                            ...List.generate(
                                scanResults.length,
                                (index) => Card(
                                    child: Text(scanResults[index].toString())))
                          ],
                        ),
                      );
                    }),
              const SizedBox(
                height: 20,
              ),
              if (isScanning)
                StreamBuilder<IBeaconDevice>(
                    stream: _beaconKontaktPlugin.listenIBeaconLost(),
                    builder: (context, snapshot) {
                      final lostDevice = snapshot.data;
                      debugPrint("lostDevice : $lostDevice");
                      return SizedBox(
                        height: 100,
                        child: ListView(
                          children: [
                            const Text(
                              "IBeaconLost Device : ",
                              textAlign: TextAlign.center,
                            ),
                            if (lostDevice != null)
                              Card(child: Text(lostDevice.toString()))
                          ],
                        ),
                      );
                    }),
              const SizedBox(
                height: 20,
              ),
              // StreamBuilder<bool>(
              //   builder: (context, snapshot) {
              //     final isBluetoothActive = snapshot.data ?? false;
              //     final status = isBluetoothActive ? "Active" : "Inactive";
              //     return Text("Bluetooth is $status");
              //   },
              //   stream: _beaconKontaktPlugin.listenBluetoothServiceStatus(),
              // ),
              StreamBuilder<bool>(
                builder: (context, snapshot) {
                  final isBluetoothActive = snapshot.data ?? false;
                  final status = isBluetoothActive ? "Active" : "Inactive";
                  return Text("Location Service is $status");
                },
                stream: _beaconKontaktPlugin.listenLocationServiceStatus(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
