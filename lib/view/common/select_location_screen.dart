// view/common/select_location_screen.dart
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/res/size_const.dart';
import 'package:aim_swasthya/res/text_const.dart';
import 'package:aim_swasthya/res/user_button_const.dart';
import 'package:aim_swasthya/view_model/doctor/add_clinic_doctor_view_model.dart';
import 'package:provider/provider.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddClinicDoctorViewModel>(context, listen: false)
          .getCurrentLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AddClinicDoctorViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.blue,
        title: TextConst(
          "Select Location",
          color: AppColor.white,
          size: Sizes.fontSizeFivePFive,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SizedBox(
        height: Sizes.screenHeight,
        width: Sizes.screenWidth,
        child: viewModel.loading ||
                (viewModel.selectedLatitude == null &&
                    viewModel.selectedLongitude == null)
            ? const LoadData()
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(viewModel.selectedLatitude ?? 0.0,
                      viewModel.selectedLongitude ?? 0.0),
                  zoom: 15,
                ),
                onMapCreated: (GoogleMapController controller) {
                  viewModel.setMapController(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: {
                  Marker(
                    markerId: const MarkerId('selected_location'),
                    position: LatLng(viewModel.selectedLatitude!,
                        viewModel.selectedLongitude!),
                    draggable: true,
                    onDragEnd: (LatLng newPosition) {
                      viewModel.updateSelectedLocation(newPosition);
                    },
                  ),
                },
                onTap: (LatLng position) {
                  viewModel.updateSelectedLocation(position);
                },
                onCameraMove: (CameraPosition position) {
                  viewModel.updateSelectedLocation(position.target);
                },
              ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (viewModel.selectedAddress != null)
              TextConst(
                viewModel.selectedAddress!,
                size: Sizes.fontSizeFour,
              ),
            Sizes.spaceHeight10,
            ButtonConst(
              title: "Confirm Location",
              width: Sizes.screenWidth,
              onTap: () {
                final viewModel = Provider.of<AddClinicDoctorViewModel>(context,
                    listen: false);
                viewModel.notifyListeners();
                Navigator.pop(context);
              },
              color: AppColor.blue,
            ),
          ],
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   final viewModel = Provider.of<AddClinicDoctorViewModel>(context, listen: false);
  //   viewModel.disposeMapController();
  //   super.dispose();
  // }
}
