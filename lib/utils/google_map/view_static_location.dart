import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetLocationOnMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const GetLocationOnMap({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final LatLng position = LatLng(latitude, longitude);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: position,
        zoom: 14,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("Clinic location"),
          position: position,
        ),
      },
      liteModeEnabled: true,
      zoomControlsEnabled: false,
      myLocationEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
    );
  }
}
