import 'dart:async';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_radar/src/states/app_state.dart';

class ScanService {
  static final ScanService _scanService = ScanService._internal();
  ScanService._internal();

  factory ScanService() {
    return _scanService;
  }

  Future<List<ScanResult>> scanBluetoothDevices(AppState appState) async {
    List<ScanResult> scanResults = [];
    FlutterBlue flutterBlue = FlutterBlue.instance;

    flutterBlue
        .startScan(timeout: Duration(seconds: 4))
        .whenComplete(() => appState.updateStatus(Status.results));

    // Listen to scan results

    flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult result in results) {
        print('${result.device.name} found! rssi: ${result.rssi}');
        print('${result.device} found! rssi: ${result.rssi}');
        if (!scanResults.contains(result)) {
          scanResults.add(result);
        }
      }
    });

    // Stop scanning
    flutterBlue.stopScan();

    return scanResults;
  }
}
