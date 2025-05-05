import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  LatLng? _selectedLocation;
  Marker? _marker;

  // Getters
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  LatLng? get selectedLocation => _selectedLocation;
  Marker? get marker => _marker;

  // Setter
  void updateLocation(LatLng position) {
    print("yuhj${latitude}");
    print("yuhhhhhj${latitude}");
    _latitude = position.latitude;
    _longitude = position.latitude;
    _selectedLocation = position;
    _marker = Marker(
      markerId: MarkerId('selected_location'),
      position: position,
      infoWindow: InfoWindow(title: 'Selected Location'),
    );
    notifyListeners();
  }
}
