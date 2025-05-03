// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
//
// class SimpleBarChart extends StatefulWidget {
//   final List<String> xAxisList;
//   final String xAxisName;
//   final List<double> yAxisList;
//   final String yAxisName;
//   final double interval;
//
//   const SimpleBarChart(
//       {super.key,
//         required this.xAxisList,
//         required this.yAxisList,
//         required this.xAxisName,
//         required this.yAxisName,
//         required this.interval});
//
//   @override
//   State<SimpleBarChart> createState() => _SimpleBarChartState();
// }
//
// class _SimpleBarChartState extends State<SimpleBarChart> {
//   late List<String> xAxisList;
//   late List<double> yAxisList;
//   late String xAxisName;
//   late String yAxisName;
//   late double interval;
//
//   @override
//   void initState() {
//     super.initState();
//     xAxisList = widget.xAxisList;
//     yAxisList = widget.yAxisList;
//     xAxisName = widget.xAxisName;
//     yAxisName = widget.yAxisName;
//     interval = widget.interval;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BarChart(
//       BarChartData(
//         titlesData: FlTitlesData(
//           show: true,
//           rightTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           topTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: false),
//           ),
//           bottomTitles: AxisTitles(
//             axisNameWidget: Text(
//               xAxisName,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) =>
//                   bottomTitles(value, meta, xAxisList),
//               reservedSize: 42,
//             ),
//           ),
//           leftTitles: AxisTitles(
//             axisNameWidget: Text(
//               yAxisName,
//               style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//             ),
//             sideTitles: SideTitles(
//               showTitles: true,
//               reservedSize: 50,
//               interval: interval,
//               getTitlesWidget: leftTitles,
//             ),
//           ),
//         ),
//         borderData: FlBorderData(
//           border: const Border(
//             top: BorderSide.none,
//             right: BorderSide.none,
//             left: BorderSide(width: 1),
//             bottom: BorderSide(width: 1),
//           ),
//         ),
//         gridData: FlGridData(show: false),
//         barGroups: List.generate(
//           xAxisList.length,
//               (index) => BarChartGroupData(
//             x: index,
//             barRods: [
//               BarChartRodData(
//                   toY: yAxisList[index],
//                   width: 15,
//                   color: Colors.blue[200],
//                   borderRadius: const BorderRadius.only(
//                       topRight: Radius.circular(10),
//                       topLeft: Radius.circular(10))),
//             ],
//           ),
//         ).toList(),
//       ),
//     );
//   }
// }
//
// Widget bottomTitles(
//     double value, TitleMeta meta, List<String> bottomTilesData) {
//   final Widget text = Text(
//     bottomTilesData[value.toInt()],
//     style: const TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 12,
//     ),
//   );
//
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     space: 16,
//     child: text,
//   );
// }
//
// Widget leftTitles(double value, TitleMeta meta) {
//   final formattedValue = (value).toStringAsFixed(0);
//   final Widget text = Text(
//     formattedValue,
//     style: const TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 12,
//     ),
//   );
//
//   return SideTitleWidget(
//     axisSide: meta.axisSide,
//     space: 16,
//     child: text,
//   );
// }
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class FullScreenMapPage extends StatefulWidget {
//   const FullScreenMapPage({super.key});
//
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
//     final permission = await Permission.location.request();
//     if (!permission.isGranted) return;
//
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     LatLng latLng = LatLng(position.latitude, position.longitude);
//
//     setState(() {
//       _currentPosition = latLng;
//       _selectedMarker = Marker(
//         markerId: MarkerId("selected"),
//         position: latLng,
//         infoWindow: InfoWindow(title: "Selected Location"),
//       );
//     });
//
//     _mapController?.animateCamera(
//       CameraUpdate.newLatLngZoom(latLng, 15),
//     );
//   }
//
//   void _onMapTapped(LatLng tappedPoint) {
//     setState(() {
//       _selectedMarker = Marker(
//         markerId: MarkerId("selected"),
//         position: tappedPoint,
//         infoWindow: InfoWindow(title: "Selected Location"),
//       );
//     });
//     print("Selected LatLng: ${tappedPoint.latitude}, ${tappedPoint.longitude}");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _currentPosition == null
//           ? Center(child: CircularProgressIndicator())
//           : GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _currentPosition!,
//           zoom: 15,
//         ),
//         myLocationEnabled: true,
//         onMapCreated: (controller) => _mapController = controller,
//         markers: _selectedMarker != null ? {_selectedMarker!} : {},
//         onTap: _onMapTapped,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class FullScreenMapPage extends StatefulWidget {
  @override
  _FullScreenMapPageState createState() => _FullScreenMapPageState();
}

class _FullScreenMapPageState extends State<FullScreenMapPage> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Marker? _selectedMarker;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    await Permission.location.request();
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    LatLng latLng = LatLng(position.latitude, position.longitude);

    setState(() {
      _currentPosition = latLng;
      _selectedMarker = Marker(
        markerId: MarkerId('selected'),
        position: latLng,
        infoWindow: InfoWindow(title: 'Your Location'),
      );
    });

    _mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(latLng, 15),
    );
  }

  void _onMapTap(LatLng tappedPoint) {
    setState(() {
      _selectedMarker = Marker(
        markerId: MarkerId('selected'),
        position: tappedPoint,
        infoWindow: InfoWindow(title: 'Selected Location'),
      );
    });

    print('Selected Coordinates: ${tappedPoint.latitude}, ${tappedPoint.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location on Map'),
        backgroundColor: Colors.green,
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: (controller) => _mapController = controller,
        initialCameraPosition: CameraPosition(
          target: _currentPosition!,
          zoom: 15,
        ),
        myLocationEnabled: true,
        markers: _selectedMarker != null ? {_selectedMarker!} : {},
        onTap: _onMapTap,
      ),
    );
  }
}
