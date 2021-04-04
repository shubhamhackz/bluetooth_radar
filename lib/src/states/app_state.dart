import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  Status _status = Status.idle;
  AppState();

  updateStatus(status) {
    _status = status;
    notifyListeners();
  }

  get getStatus => _status;
}

enum Status { idle, scanning, results }
