import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bluetooth_enable/bluetooth_enable.dart';
import 'package:bluetooth_radar/src/components/transparent_button.dart';

class BluetoothOffWidget extends StatelessWidget {
  final BluetoothState state;
  BluetoothOffWidget({@required this.state});
  @override
  Widget build(BuildContext context) {
    print('Type : ${state.toString()}');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            decoration: ShapeDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Icon(
              Icons.bluetooth_disabled,
              color: Colors.white,
              size: 76,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Bluetooth Adapter is ${state != null ? state.toString().substring(15) : 'not available'}.',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Visibility(
            visible: state == BluetoothState.off,
            child: TransparentButton(
              text: 'Turn On Bluetooth',
              onPressed: () {
                // Request to turn on Bluetooth within an app
                bluetoothTurnOnRequest(context);
              },
              // style: ElevatedButton.styleFrom(primary: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> bluetoothTurnOnRequest(BuildContext context) async {
    String dialogTitle = "Bluetooth Radar";
    bool displayDialogContent = true;
    String dialogContent = "Turn on Bluetooth to scan nearby devices.";
    String cancelBtnText = "Cancel";
    String acceptBtnText = "Turn on";
    double dialogRadius = 10.0;
    bool barrierDismissible = false; //

    BluetoothEnable.customBluetoothRequest(
            context,
            dialogTitle,
            displayDialogContent,
            dialogContent,
            cancelBtnText,
            acceptBtnText,
            dialogRadius,
            barrierDismissible)
        .then((result) {
      if (result == "true") {
        //Bluetooth has been enabled
      }
    });
  }
}
