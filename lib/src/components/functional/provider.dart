import 'package:flutter/material.dart';
import 'package:bluetooth_radar/src/states/app_state.dart';

class Provider extends InheritedWidget {
  Provider({Key key, this.child, this.appState})
      : super(key: key, child: child);

  final Widget child;
  final AppState appState;

  static Provider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>();
  }

  @override
  bool updateShouldNotify(Provider oldWidget) {
    return true;
  }
}
