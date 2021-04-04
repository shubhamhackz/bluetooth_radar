import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:location/location.dart';
import 'package:bluetooth_radar/src/components/bottom_sheet_widget.dart';
import 'package:bluetooth_radar/src/services/location_service.dart';
import 'package:bluetooth_radar/src/services/scan_service.dart';
import 'package:bluetooth_radar/src/states/app_state.dart';
import 'package:bluetooth_radar/src/components/functional/provider.dart';

class AnimatedRadar extends StatefulWidget {
  @override
  _AnimatedRadarState createState() => _AnimatedRadarState();
}

class _AnimatedRadarState extends State<AnimatedRadar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Location location = new Location();
  AppState _appState;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.5,
      duration: Duration(milliseconds: 1200),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appState = Provider.of(context).appState;
    _appState.addListener(() {
      // setState(() {
      //   if (_appState.getStatus == Status.results) {
      //     _controller.reset();
      //   }
      // });
      if (_appState.getStatus == Status.results) {
        _controller.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildContainer(250 * _controller.value),
            // _buildContainer(200 * _controller.value),
            _buildContainer(350 * _controller.value),
            // _buildContainer(300 * _controller.value),
            _buildContainer(450 * _controller.value),
            GestureDetector(
              onTap: () async {
                await LocationService().checkLocationService();
                // if (_controller.isAnimating) {
                //   _controller.reset();
                // } else {
                _controller.repeat();
                _appState.updateStatus(Status.scanning);
                // }
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Icon(
                  Icons.bluetooth,
                  size: 76,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContainer(double radius) {
    return Visibility(
      visible: _controller.isAnimating,
      child: Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(1 - _controller.value),
        ),
      ),
    );
  }
}
