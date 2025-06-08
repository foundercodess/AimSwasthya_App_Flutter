// utils/google_map/view_static_location.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationOnMap extends StatefulWidget {
  final double latitude;
  final double longitude;
  final String? clinicName;
  final String? address;

  const GetLocationOnMap({
    super.key,
    required this.latitude,
    required this.longitude,  this.clinicName,  this.address,
  });

  @override
  State<GetLocationOnMap> createState() => _GetLocationOnMapState();
}

class _GetLocationOnMapState extends State<GetLocationOnMap> {
  GoogleMapController? _mapController;
  late LatLng _position;

  @override
  void initState() {
    super.initState();
    _position = LatLng(widget.latitude, widget.longitude);
  }

  @override
  void didUpdateWidget(GetLocationOnMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.latitude != widget.latitude || oldWidget.longitude != widget.longitude) {
      _position = LatLng(widget.latitude, widget.longitude);
      _updateCameraPosition();
    }
  }

  void _updateCameraPosition() {
    if (_mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(_position),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _position,
        zoom: 16,
      ),
      onMapCreated: (GoogleMapController controller) {
        _mapController = controller;
      },
      markers: {
        Marker(
          markerId: const MarkerId("Clinic location"),
          position: _position,
          infoWindow: InfoWindow(title: widget.clinicName, snippet: widget.address)
        ),
      },
      liteModeEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
