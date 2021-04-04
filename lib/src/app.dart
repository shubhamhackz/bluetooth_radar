import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:bluetooth_radar/src/components/functional/provider.dart';
import 'package:bluetooth_radar/src/screens/home_screen.dart';

import 'package:bluetooth_radar/src/states/app_state.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: const Color(0xFF5691DB),
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return Provider(
      appState: AppState(),
      child: MaterialApp(
        color: Colors.lightBlue,
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ),
    );
  }
}
