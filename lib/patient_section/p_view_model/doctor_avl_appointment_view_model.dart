// patient_section/p_view_model/doctor_avl_appointment_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/model/user/doctor_avl_appointment_model.dart';
import 'package:aim_swasthya/patient_section/p_repo/doctor_avl_appointment_repo.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/patient_home_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/services/map_con.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:aim_swasthya/patient_section/p_view_model/voice_search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import 'package:aim_swasthya/common/view_model/notification_view_model.dart';

class DoctorAvlAppointmentViewModel extends ChangeNotifier {
  final avlTimeType = ['Morning', 'Afternoon', 'Evening'];
  final _doctorAvlAppointmentRepo = DoctorAvlAppointmentRepo();
  final _mapCon = MapController();
  bool _loading = false;
  bool get loading => _loading;

  DoctorAvlAppointmentModel? _doctorAvlAppointmentModel;

  DoctorAvlAppointmentModel? get doctorAvlAppointmentModel =>
      _doctorAvlAppointmentModel;

  double _payableAmountAfterDiscount = 0.0;
  double get payableAmountAfterDiscount => _payableAmountAfterDiscount;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Slots? _selectedData;
  Slots? get selectedDate => _selectedData;
  setSelectedDate(Slots? value) {
    _selectedData = value;
    notifyListeners();
  }

  bool _showConfirmDialog = false;
  bool get showConfirmDialog => _showConfirmDialog;
  setConfirmDialog(bool value) {
    _showConfirmDialog = value;
    notifyListeners();
  }

  AvailableTime? _selectedTime;
  AvailableTime? get selectedTime => _selectedTime;
  setSelectedTimeData(AvailableTime value) {
    _selectedTime = value;
    notifyListeners();
  }

  void clearSelectedTime() {
    _selectedTime = null;
    notifyListeners();
  }

  String _selectedTimeType = 'Morning';
  String get selectedTimeType => _selectedTimeType;
  setSelectedTimeTypeData(String value) {
    _selectedTimeType = value;
    notifyListeners();
  }

  setDoctorAppointmentData(DoctorAvlAppointmentModel value) {
    _doctorAvlAppointmentModel = value;
    notifyListeners();
    if (value.data!.slots!.isNotEmpty) {
      setSelectedDate(value.data!.slots![0]);
    } else {
      setSelectedDate(null);
    }
    if (value.data!.clinics!.isNotEmpty){
      _payableAmountAfterDiscount= double.tryParse(value.data!.clinics![0].fee.toString())??0.0;
    }
    _selectedClinicId='';
    // if (value.data!.location!.isNotEmpty) {
    //   final location = value.data!.location![0];
    //   _payableAmountAfterDiscount = double.parse(location.fee.toString());
    //   // -
    //   // double.parse(location.digiswasthyaDiscount.toString());
    // }
    notifyListeners();
  }

  Future<void> doctorAvlAppointmentApi(dynamic docId, dynamic clinicId, context,
      {bool clearCon = true}) async {
    if (clearCon) {
      clearSelectedTime();
      _doctorAvlAppointmentModel = null;
      notifyListeners();
    }

    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.parse(locationData!.latitude.toString());
    double longitude = double.parse(locationData.longitude.toString());
    final selectedLocation =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    if (selectedLocation == null) {
      debugPrint("Location data not found");
      return;
    }
    setLoading(clearCon);
    final userId = await UserViewModel().getUser();
    Map data = {
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
      "patient_id": userId,
      "doctor_id": docId,
      "clinic_id": clinicId,
    };
    _doctorAvlAppointmentRepo.doctorAvlAppointmentApi(data).then((value) {
      if (value.status == true) {
        setDoctorAppointmentData(value);
      } else {
        showInfoOverlay(
            title: "Info",
            errorMessage: '${value.msg}',
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            });
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  dynamic _paymentReqData;
  dynamic get paymentReqData => _paymentReqData;
  setPaymentReqData(dynamic value) {
    _paymentReqData = value;
    notifyListeners();
  }

  dynamic _requestData;
  dynamic get requestData => _requestData;

  setRequestData(dynamic value, context) {
    _requestData = value;
    Navigator.pushNamed(context, RoutesName.bookAppointmentScreen);
    notifyListeners();
  }

  String getPaymentStatus(int status) {
    switch (status) {
      case 1:
        return 'Completed';
      case 2:
        return 'failed';
      default:
        return 'pending';
    }
  }

  Future<void> doctorBookAppointmentApi(
      BuildContext context,
      dynamic docId,
      dynamic clinicId,
      dynamic paymentRes,
      String payMode,
      int paymentStatus) async {
    final bookingDate = DateFormat("yyyy-MM-dd").format(
      DateFormat("dd-MM-yyyy").parse(selectedDate!.availabilityDate.toString()),
    );

    final symptoms =
        Provider.of<VoiceSymptomSearchViewModel>(context, listen: false)
            .symptomsData;
    setLoading(true);
    _requestData["payment_date"] = DateTime.now().toString();
    final userId = await UserViewModel().getUser();
    Map data = {
      "patient_id": userId,
      "doctor_id": docId,
      "clinic_id": clinicId,
      "booking_date": bookingDate,
      "time_id": selectedTime!.timeId,
      "amount": payableAmountAfterDiscount,
      "payment_status": getPaymentStatus(paymentStatus),
      "payment_date": _requestData["payment_date"],
      "response_payment_id": paymentRes['payment_id'],
      "payment_response": jsonEncode(paymentRes),
      "payment_method": payMode,
      'symptoms': symptoms
    };
    debugPrint("appointment booking data: ${jsonEncode(data)}");
    _doctorAvlAppointmentRepo
        .doctorBookAppointmentApi(data)
        .then((value) async {
      debugPrint("$value");
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        final notificationViewModel =
            Provider.of<NotificationViewModel>(context, listen: false);
        await notificationViewModel.sendAppointmentStatusNotification(
          patientId: userId,
          doctorId: docId,
          appointmentDate: bookingDate,
          appointmentTime: selectedTime!.slotTime!,
          role: 'patient',
          context: context,
          isCompleted: false,
          isMissed: false,
        );

        Provider.of<PatientHomeViewModel>(context, listen: false)
            .patientHomeApi(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          RoutesName.successSplashScreen,
          (Route<dynamic> route) =>
              route.settings.name == RoutesName.bottomNavBar,
        );
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }

  String _selectedClinicId = '';
  String get selectedClinicId => _selectedClinicId;
  setSelectedClinic(String id) {
    _selectedClinicId = id;
    notifyListeners();
  }

  String getFormattedDate(String date) {
    DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(date);
    String formattedDate = DateFormat("EEE,d").format(parsedDate);
    return formattedDate;
  }

  Future<void> addDoctorToFavApi(dynamic docId, context,
      {dynamic clinicId}) async {
    final userId = await UserViewModel().getUser();
    final locationData =
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .selectedLocationData;
    double latitude = double.parse(locationData!.latitude.toString());
    double longitude = double.parse(locationData.longitude.toString());
    Map data = {
      "lat": latitude,
      "lon": longitude,
      "clinic_id": clinicId,
      "patient_id": userId,
      "doctor_id": docId,
    };
    _doctorAvlAppointmentRepo.addDoctorToFavApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        if (clinicId != null) {
          doctorAvlAppointmentApi(docId, clinicId, context, clearCon: false);
        }
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
