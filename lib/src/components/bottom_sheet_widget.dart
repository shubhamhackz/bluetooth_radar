import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_radar/src/screens/device_detail_screen.dart';

class BottomSheetWidget extends StatelessWidget {
  BottomSheetWidget({this.scanResults});
  final List<ScanResult> scanResults;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 5),
            width: 100,
            height: 7,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Expanded(
            child: scanResults.isNotEmpty
                ? ListView(
                    children: List.generate(
                      scanResults.length,
                      (index) {
                        var result = scanResults[index];
                        return makeListTile(
                          result,
                          context,
                        );
                      },
                    ),
                  )
                : Center(
                    child: Text(
                      'No Device Found.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  makeListTile(ScanResult scanResult, context) {
    var device = scanResult.device;
    var rssi = scanResult.rssi;
    return Material(
      color: Colors.white.withOpacity(0.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DeviceDetailScreen(
                device: scanResult.device,
                rssi: rssi,
              ),
            ),
          );
        },
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right:
                          new BorderSide(width: 1.0, color: Colors.white24))),
              child: Icon(Icons.bluetooth, color: Colors.white),
            ),
            title: Text(
              device.name.isEmpty ? 'Unknow Device' : device.name,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Row(
              children: <Widget>[
                Icon(Icons.linear_scale, color: Colors.yellowAccent),
                Text("RSSI : $rssi DB", style: TextStyle(color: Colors.white))
              ],
            ),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white, size: 30.0)),
      ),
    );
  }
}
