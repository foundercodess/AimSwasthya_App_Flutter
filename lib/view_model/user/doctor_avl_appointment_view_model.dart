import 'dart:convert';
import 'package:aim_swasthya/model/user/doctor_avl_appointment_model.dart';
import 'package:aim_swasthya/repo/user/doctor_avl_appointment_repo.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/patient_home_view_model.dart';
import 'package:aim_swasthya/view_model/user/services/map_con.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:aim_swasthya/view_model/user/voice_search_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';

enum avlTimeType { Morning, Afternoon, Evening }

class DoctorAvlAppointmentViewModel extends ChangeNotifier {
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
  setSelectedDate(Slots value) {
    _selectedData = value;
    notifyListeners();
  }

  bool _showConfirmDailog = false;
  bool get showConfirmDailog => _showConfirmDailog;
  setConfirmDailog(bool value) {
    _showConfirmDailog = value;
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

  String _selectedMonth = avlTimeType.Morning.toString().split('.').last;
  String get selectedMonth => _selectedMonth;
  setSelectedMonthData(avlTimeType value) {
    print("dddddd $value");
    _selectedMonth = value.toString().split('.').last;
    notifyListeners();
  }

  setDoctorAppointmentData(DoctorAvlAppointmentModel value) {
    _doctorAvlAppointmentModel = value;
    notifyListeners();
    setSelectedDate(value.data!.slots![0]);
    if (value.data!.location!.isNotEmpty) {
      final location = value.data!.location![0];
      _payableAmountAfterDiscount = double.parse(location.fee.toString());
      // -
      // double.parse(location.digiswasthyaDiscount.toString());
    }
    notifyListeners();
  }

  Future<void> doctorAvlAppointmentApi(
      dynamic docId, dynamic clinicId, context,
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
    setLoading(true);
    final userId = await UserViewModel().getUser();
    Map data = {
      "lat": latitude.toStringAsFixed(5),
      "lon": longitude.toStringAsFixed(5),
      "patient_id": userId,
      "doctor_id": docId,
      "clinic_id": clinicId,
    };
    print("hgfhg ${jsonEncode(data)}");
    _doctorAvlAppointmentRepo.doctorAvlAppointmentApi(data).then((value) {
      if (value.status == true) {
        setDoctorAppointmentData(value);
      }else{
        showInfoOverlay(title: "Info", errorMessage: '${value.message}', onTap: (){
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
      "booking_date": DateFormat("yyyy-MM-dd")
          .format(DateTime.parse(selectedDate!.availabilityDate.toString())),
      "time_id": selectedTime!.timeId,
      "amount": payableAmountAfterDiscount,
      "payment_status": getPaymentStatus(paymentStatus),
      "payment_date": _requestData["payment_date"],
      "response_payment_id": paymentRes['payment_id'],
      "payment_response": jsonEncode(paymentRes),
      "payment_method": payMode,
      'symptoms': symptoms
    };
    print("hgdgh: $data");
    debugPrint("appointment booking data: ${jsonEncode(data)}");
    _doctorAvlAppointmentRepo.doctorBookAppointmentApi(data).then((value) {
      debugPrint("$value");
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        Provider.of<PatientHomeViewModel>(context, listen: false)
            .patientHomeApi(context);
        Navigator.pushReplacementNamed(context, RoutesName.successSplashScreen);
        // Navigator.pushNamed(context, RoutesName.successSplashScreen);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
