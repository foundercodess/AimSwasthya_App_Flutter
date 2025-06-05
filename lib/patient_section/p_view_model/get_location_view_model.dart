// import 'package:aim_swasthya/repo/user/get_location_repo.dart';
// import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
// import 'package:aim_swasthya/view_model/user/services/map_con.dart';
// import 'package:aim_swasthya/view_model/user/user_view_model.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:provider/provider.dart';
// import '../../model/user/get_location_model.dart';
//
// class GetLocationViewModel extends ChangeNotifier {
//   // final _getLocationRepo = GetLocationRepo();
//   // final _mapCon = MapController();
//   // bool _loading = false;
//   // bool get loading => _loading;
//   // GetLocationModel? _locationData;
//   // GetLocationModel? get locationData => _locationData;
//   //
//   // Locations? _selectedLocationData;
//   // Locations? get selectedLocationData => _selectedLocationData;
//   // setLoading(bool value) {
//   //   _loading = value;
//   //   notifyListeners();
//   // }
//   //
//   // setLocationData(GetLocationModel value) {
//   //   _locationData = value;
//   //   _selectedLocationData = value.patientLocation!;
//   //   // if(value.patientLocation)
//   //   // _selectedLocationData= SelectedLocationData(id: id, name: name, lat: lat, lng: lng)
//   //   notifyListeners();
//   // }
//   //
//   // Future<void> getLocationApi(BuildContext context) async {
//   //   Position position = await _mapCon.getCurrentLocation();
//   //   double latitude = position.latitude;
//   //   double longitude = position.longitude;
//   //   final userId = await UserViewModel().getUser();
//   //   setLoading(true);
//   //   Map data = {
//   //     "lat": latitude.toStringAsFixed(5),
//   //     "lon": longitude.toStringAsFixed(5),
//   //     "patient_id": userId
//   //   };
//   //   _getLocationRepo.getLocationApi(data).then((value) {
//   //     if (value.status == true) {
//   //       setLocationData(value);
//   //       Provider.of<PatientHomeViewModel>(context, listen: false).patientHomeApi(context, _selectedLocationData);
//   //     }
//   //   }).onError((error, stackTrace) {
//   //     if (kDebugMode) {
//   //       print('error: $error');
//   //     }
//   //   });
//   // }
// }
