import 'dart:async';

import 'package:bluetooth_radar/src/components/bottom_sheet_widget.dart';
import 'package:bluetooth_radar/src/components/functional/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart';
import 'package:bluetooth_radar/src/components/animated_radar.dart';
import 'package:bluetooth_radar/src/services/location_service.dart';
import 'package:bluetooth_radar/src/services/scan_service.dart';
import 'package:bluetooth_radar/src/states/app_state.dart';

class ScanDevicesWidget extends StatefulWidget {
  @override
  _ScanDevicesWidgetState createState() => _ScanDevicesWidgetState();
}

class _ScanDevicesWidgetState extends State<ScanDevicesWidget>
    with SingleTickerProviderStateMixin {
  Location location = new Location();
  int androidVersion;
  AppState _appState;
  List<ScanResult> scanResults = [];
  @override
  void initState() {
    super.initState();
    LocationService().checkLocationService();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appState = Provider.of(context).appState;
    _appState.addListener(() async {
      if (_appState.getStatus == Status.scanning) {
        scanResults = [];
        scanResults = await ScanService().scanBluetoothDevices(_appState);
      } else if (_appState.getStatus == Status.results) {
        showModalBottomSheet(
          backgroundColor: Colors.white.withOpacity(0.2),
          context: context,
          builder: (context) {
            return BottomSheetWidget(
              scanResults: scanResults,
            );
          },
          // transitionAnimationController: AnimationController(
          //   vsync: this,
          //   duration: const Duration(milliseconds: 500),
          // ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: AnimatedRadar()),
          Container(
            padding: const EdgeInsets.only(bottom: 50),
            child: Text(
              'Tap to scan',
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
