import 'package:beacon_kontakt/listener_type_enum.dart';
import 'package:beacon_kontakt/permission_enum.dart';
import 'package:beacon_kontakt/scan_period_enum.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:beacon_kontakt/beacon_kontakt.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _beaconKontaktPlugin = BeaconKontakt();
  late final StreamSubscription permissionStatusStreamSubscription;

  @override
  void initState() {
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
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search), 
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
                        ListenerType.iBeacon,
                        'f2142874-611b-11ed-9b6a-0242ac120002',
                        1,
                        3674);
                  },
                  child: Text("Start Scanning")),
              TextButton(
                  onPressed: () async {
                    await _beaconKontaktPlugin.stopScanning();
                    // _beaconKontaktPlugin.listenScanResults().listen((event) {
                    //   print(event);
                    // });
                  },
                  child: Text(
                    "Stop Scanning",
                    style: TextStyle(color: Colors.red),
                  )),
              StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _beaconKontaktPlugin.listenScanResults(),
                  initialData: [],
                  builder: (context, snapshot) {
                    final devices = snapshot.data;
                    return Text(devices.toString());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
