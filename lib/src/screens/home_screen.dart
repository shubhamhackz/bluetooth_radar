import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_radar/src/components/scan_devices_widget.dart';
import 'package:bluetooth_radar/src/components/bluetooth_off_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5691DB),
      body: StreamBuilder<BluetoothState>(
        stream: FlutterBlue.instance.state,
        initialData: BluetoothState.unknown,
        builder: (c, snapshot) {
          final state = snapshot.data;
          if (state == BluetoothState.on) {
            return ScanDevicesWidget();
          }
          return BluetoothOffWidget(state: state);
        },
      ),
    );
  }
}
