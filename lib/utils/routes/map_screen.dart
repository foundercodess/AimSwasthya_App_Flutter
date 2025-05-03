import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController? mapController;
  LatLng? _currentPosition;
  String _address = 'Move marker to get address';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _getAddressFromLatLng(_currentPosition!);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;
      setState(() {
        _address =
        "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _address = "Could not fetch address";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map with Marker")),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: (controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 16.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("selected-location"),
                  position: _currentPosition!,
                  draggable: true,
                  onDragEnd: (newPosition) {
                    setState(() {
                      _currentPosition = newPosition;
                    });
                    _getAddressFromLatLng(newPosition);
                  },
                ),
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.white,
            child: Text("Address: $_address"),
          )
        ],
      ),
    );
  }
}
