// doctor_section/d_view_model/add_clinic_doctor_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/doctor_section/d_repo/addClinicDoctorRopo.dart';
import 'package:aim_swasthya/doctor_section/d_view_model/doctor_profile_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/services/map_con.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';

class AddClinicDoctorViewModel extends ChangeNotifier {
  final _mapCon = MapController();
  final _addClinicDoctorRepo = AddClinicDoctorRepo();
  bool _loading = true;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  // Add edit-related properties
  bool _isEditMode = false;
  bool get isEditMode => _isEditMode;
  
  int? _editingClinicIndex;
  int? get editingClinicIndex => _editingClinicIndex;

  void setEditMode(bool value, {int? clinicIndex}) {
    _isEditMode = value;
    _editingClinicIndex = clinicIndex;
    notifyListeners();
  }

  void clearEditMode() {
    _isEditMode = false;
    _editingClinicIndex = null;
    notifyListeners();
  }

  // Add clinic data properties for editing
  String? _editClinicName;
  String? _editClinicAddress;
  String? _editClinicPhone;
  String? _editClinicLandmark;
  String? _editClinicCity;
  double? _editClinicLatitude;
  double? _editClinicLongitude;
  String? _editClinicId;
  String? _editCFees;

  // Getters for edit data
  String? get editClinicName => _editClinicName;
  String? get editClinicAddress => _editClinicAddress;
  String? get editClinicPhone => _editClinicPhone;
  String? get editClinicLandmark => _editClinicLandmark;
  String? get editClinicCity => _editClinicCity;
  double? get editClinicLatitude => _editClinicLatitude;
  double? get editClinicLongitude => _editClinicLongitude;
  String? get editClinicId => _editClinicId;
  String? get editCFees => _editCFees;

  // Setter for edit data
  void setEditClinicData({
    String? name,
    String? address,
    String? phone,
    String? landmark,
    String? city,
    double? latitude,
    double? longitude,
    String? clinicId,
    String? editCFees
  }) {
    _editClinicName = name;
    _editClinicAddress = address;
    _editClinicPhone = phone;
    _editClinicLandmark = landmark;
    _editClinicCity = city;
    _editClinicLatitude = latitude;
    _editClinicLongitude = longitude;
    _editClinicId= clinicId;
    _editCFees = editCFees;
    notifyListeners();
  }

  // Clear edit data
  void clearEditClinicData() {
    _editClinicName = null;
    _editClinicAddress = null;
    _editClinicPhone = null;
    _editClinicLandmark = null;
    _editClinicCity = null;
    _editClinicLatitude = null;
    _editClinicLongitude = null;
    _editClinicId= null;
    _editCFees = null;
    notifyListeners();
  }

  bool _isClicked = false;
  bool get isClicked => _isClicked;
  setClinicData(bool value) {
    _isClicked = value;
    notifyListeners();
  }

  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedAddress;
  String? selectedCity;
  GoogleMapController? mapController;

  clearSelectedLocation(){
    selectedAddress = null;
    selectedLatitude = null;
    selectedLongitude = null;
    selectedCity = null;
    notifyListeners();
  }

  Future<void> getCurrentLocation() async {
    try {
      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      selectedLatitude = position.latitude;
      selectedLongitude = position.longitude;
      setLoading(false);
      notifyListeners();

      // Get address for current position
      await getAddressFromLatLng(LatLng(position.latitude, position.longitude));
    } catch (e) {
      print('Error getting location: $e');
      setLoading(false);
      notifyListeners();
    }
  }

  Future<void> getAddressFromLatLng(LatLng position) async {
    try {
      // List of coordinate offsets to try (in degrees)
      final List<Map<String, double>> offsets = [
        {'lat': 0.0, 'lng': 0.0},      // Original coordinates
        {'lat': 0.0001, 'lng': 0.0},   // Slight north
        {'lat': -0.0001, 'lng': 0.0},  // Slight south
        {'lat': 0.0, 'lng': 0.0001},   // Slight east
        {'lat': 0.0, 'lng': -0.0001},  // Slight west
      ];

      List<Placemark>? placemarks;
      
      // Try each offset until we get a result
      for (var offset in offsets) {
        try {
          placemarks = await placemarkFromCoordinates(
            position.latitude + offset['lat']!,
            position.longitude + offset['lng']!,
          );
          
          if (placemarks.isNotEmpty) {
            break;
          }
        } catch (e) {
          print('Attempt failed with offset ${offset}: $e');
          continue;
        }
      }

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        
        // Build address components
        List<String> addressParts = [];
        if (place.street?.isNotEmpty ?? false) addressParts.add(place.street!);
        if (place.subLocality?.isNotEmpty ?? false) addressParts.add(place.subLocality!);
        if (place.locality?.isNotEmpty ?? false) addressParts.add(place.locality!);
        if (place.postalCode?.isNotEmpty ?? false) addressParts.add(place.postalCode!);
        if (place.country?.isNotEmpty ?? false) addressParts.add(place.country!);
        
        selectedAddress = addressParts.isNotEmpty ? addressParts.join(', ') : 
            'Location selected (${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)})';
        
        // Try to get city name with multiple fallbacks
        selectedCity = place.locality ?? 
                      place.subAdministrativeArea ?? 
                      place.administrativeArea ?? 
                      place.subLocality ?? 
                      place.name ?? 
                      'Unknown City';
      } else {
        // If all attempts failed, set default values
        selectedAddress = 'Location selected (${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)})';
        selectedCity = 'Unknown City';
      }
      notifyListeners();
    } catch (e) {
      print('Error getting address: $e');
      // Set default values when all attempts fail
      selectedAddress = 'Location selected (${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)})';
      selectedCity = 'Unknown City';
      notifyListeners();
    }
  }

  void updateSelectedLocation(LatLng position) {
    selectedLatitude = position.latitude;
    selectedLongitude = position.longitude;
    getAddressFromLatLng(position);
    notifyListeners();
  }

  void setMapController(GoogleMapController controller) {
    if (mapController != null) {
      mapController!.dispose();
    }
    mapController = controller;
  }

  void disposeMapController() {
    if (mapController != null) {
      mapController!.dispose();
      mapController = null;
    }
  }

  Future<void> addClinicDoctorApi(dynamic clinicId,dynamic clinicName, dynamic address,dynamic city,
      dynamic phone, dynamic landMark, dynamic fee,context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {
      "doctor_id": userId.toString(),
      "clinic_id":clinicId,
      "name": clinicName,
      "address": address,
      "fee": fee,
      "phone_number": phone,
      "city": city,
      "latitude": selectedLatitude!.toStringAsFixed(5),
      "longitude": selectedLongitude!.toStringAsFixed(5),
      "landmark": landMark
    };

    debugPrint("payload: ${jsonEncode(data)}");
    _addClinicDoctorRepo.addClinicDocApi(data).then((value) {
      if (value ["status"] == true) {
        setClinicData(true);
        Provider.of<DoctorProfileViewModel>(context, listen:false).doctorProfileApi(context, isLoad: false);
        // If in edit mode, turn it off after successful API call
        if (isEditMode) {
          setEditMode(false, clinicIndex: -1);
          clearEditClinicData();
          // Also turn off the profile screen's edit mode
          Provider.of<DoctorProfileViewModel>(context, listen: false).setEditMode(false);
        }
      }
      setClinicData(true);
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }
}
