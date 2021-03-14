import 'package:location/location.dart';

class GetLocation{
  retrieveLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        print('Service is not enabled');
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        print('location server permission not granted');
        return;
      }
    }

    // var coord = await location.getLocation();
    return await location.getLocation();
    // postEntryField.latitude = coord.latitude;
    // postEntryField.longitude = coord.longitude;
  }
}
