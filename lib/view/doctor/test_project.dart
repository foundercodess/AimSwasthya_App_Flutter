// view/doctor/test_project.dart
import 'package:aim_swasthya/view_model/doctor/doc_map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


class FullScreenMapPage extends StatefulWidget {
  @override
  _FullScreenMapPageState createState() => _FullScreenMapPageState();
}

class _FullScreenMapPageState extends State<FullScreenMapPage> {
  GoogleMapController? _mapController;
  LatLng? _initialPosition;

  @override
  void initState() {
    super.initState();
    _setCurrentLocation();
  }

  Future<void> _setCurrentLocation() async {
    await Permission.location.request();

    bool locationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng currentLatLng = LatLng(pos.latitude, pos.longitude);
    Provider.of<MapViewModel>(context, listen: false).updateLocation(currentLatLng);

    setState(() {
      _initialPosition = currentLatLng;
    });

    _mapController?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 15));
  }

  void _onMapTapped(LatLng tappedLatLng) {
    Provider.of<MapViewModel>(context, listen: false).updateLocation(tappedLatLng);
  }

  @override
  Widget build(BuildContext context) {
    final mapVM = Provider.of<MapViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title:const Text('Select Location on Map'),
        backgroundColor: Colors.green,
      ),
      body: _initialPosition == null
          ?const Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialPosition!,
          zoom: 15,
        ),
        onMapCreated: (controller) => _mapController = controller,
        myLocationEnabled: true,
        markers: mapVM.marker != null ? {mapVM.marker!} : {},
        onTap: _onMapTapped,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class FullScreenMapPage extends StatefulWidget {
//   @override
//   _FullScreenMapPageState createState() => _FullScreenMapPageState();
// }
//
// class _FullScreenMapPageState extends State<FullScreenMapPage> {
//   GoogleMapController? _mapController;
//   LatLng? _currentPosition;
//   Marker? _selectedMarker;
//
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentLocation();
//   }
//
//   Future<void> _getCurrentLocation() async {
//     await Permission.location.request();
//     bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!isLocationEnabled) {
//       await Geolocator.openLocationSettings();
//       return;
//     }
//
//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     LatLng latLng = LatLng(position.latitude, position.longitude);
//
//     setState(() {
//       _currentPosition = latLng;
//       _selectedMarker = Marker(
//         markerId: MarkerId('selected'),
//         position: latLng,
//         infoWindow: InfoWindow(title: 'Your Location'),
//       );
//     });
//
//     _mapController?.animateCamera(
//       CameraUpdate.newLatLngZoom(latLng, 15),
//     );
//   }
//
//   void _onMapTap(LatLng tappedPoint) {
//     setState(() {
//       _selectedMarker = Marker(
//         markerId: MarkerId('selected'),
//         position: tappedPoint,
//         infoWindow: InfoWindow(title: 'Selected Location'),
//       );
//     });
//
//     print('Selected Coordinates: ${tappedPoint.latitude}, ${tappedPoint.longitude}');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Location on Map'),
//         backgroundColor: Colors.green,
//       ),
//       body: _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         onMapCreated: (controller) => _mapController = controller,
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition!,
//           zoom: 15,
//         ),
//         myLocationEnabled: true,
//         markers: _selectedMarker != null ? {_selectedMarker!} : {},
//         onTap: _onMapTap,
//       ),
//     );
//   }
// }
