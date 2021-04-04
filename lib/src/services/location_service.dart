import 'package:device_info/device_info.dart';
import 'package:location/location.dart';

class LocationService {
  Location _location;

  static final LocationService _locationService = LocationService._internal();

  LocationService._internal() {
    _location = Location();
  }

  factory LocationService() {
    return _locationService;
  }

  checkLocationService() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    if (await checkAndroidVersion() >= 29) {
      _serviceEnabled = await _location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await _location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await _location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await _location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    }
  }

  Future<int> checkAndroidVersion() async {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    var sdkInt = androidInfo.version.sdkInt;
    print('sdkInt : $sdkInt');
    return sdkInt;
  }
}
