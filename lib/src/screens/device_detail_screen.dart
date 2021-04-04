import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_radar/src/components/transparent_button.dart';

class DeviceDetailScreen extends StatefulWidget {
  DeviceDetailScreen({this.device, this.rssi});
  final BluetoothDevice device;
  final int rssi;

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.085),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(context);
            },
            child: Container(
                margin: EdgeInsets.only(top: width * 0.1, left: width * 0.025),
                padding: EdgeInsets.all(width * 0.05),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(Icons.arrow_back)),
          ),
        ),
      ),
      backgroundColor: const Color(0xFF5691DB),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(35),
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadows: <BoxShadow>[
                  BoxShadow(
                    color: Colors.white.withOpacity(0.1),
                    offset: Offset(10, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.device.name.isEmpty
                        ? 'Unknow Device'
                        : widget.device.name,
                    style: const TextStyle(fontSize: 32),
                  ),
                  Text('Mac Address : ${widget.device.id}'),
                  Text('Device Type : ${getDeviceType(widget.device.type)}'),
                  StreamBuilder(
                    stream: widget.device.isDiscoveringServices,
                    builder: (_, AsyncSnapshot snapshot) {
                      print('Snapshot : ${snapshot.runtimeType}');
                      return Text('Is Discovering : ${snapshot.data}');
                    },
                  ),
                  Text('RSSI : ${widget.rssi} DB'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder<BluetoothDeviceState>(
              stream: widget.device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (BuildContext context,
                  AsyncSnapshot<BluetoothDeviceState> snapshot) {
                VoidCallback onPressed;
                String text;
                print('Status : ${snapshot.data}');
                switch (snapshot.data) {
                  case BluetoothDeviceState.connected:
                    onPressed = () {
                      widget.device.disconnect();
                    };
                    text = 'DISCONNECT';
                    break;
                  case BluetoothDeviceState.disconnected:
                    onPressed = () {
                      widget.device.connect();
                    };
                    text = 'CONNECT';
                    break;
                  default:
                    onPressed = null;
                    text = snapshot.data.toString().substring(21).toUpperCase();
                    break;
                }
                return TransparentButton(onPressed: onPressed, text: text);
              },
            ),
          ],
        ),
      ),
    );
  }

  getDeviceType(bluetoothDeviceType) {
    String deviceType;
    switch (bluetoothDeviceType) {
      case BluetoothDeviceType.classic:
        deviceType = 'CLASSIC';
        break;
      case BluetoothDeviceType.le:
        deviceType = 'Low Energy (LE)';
        break;
      case BluetoothDeviceType.dual:
        deviceType = 'DUAL';
        break;
      case BluetoothDeviceType.le:
        deviceType = 'UNKNOWN';
        break;
    }
    return deviceType;
  }
}
