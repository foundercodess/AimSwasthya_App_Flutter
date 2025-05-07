import 'dart:convert';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/doctor/doc_schedule_model.dart';
import '../../repo/doctor/doc_schedule_repo.dart';

class SlotScheduleViewModel extends ChangeNotifier {
  final _docScheduleRepo = DocScheduleRepo();
  bool _loading = false;
  bool get loading => _loading;
  List<String> appointmentDurationList = ['15 min', '30 min'];
  String? _selectedClinicId;
  String? get selectedClinicId => _selectedClinicId;
  String _appointmentDuration = '15 min';
  String get appointmentDuration => _appointmentDuration;

  DateTimeRange? _selectedRange;

  DateTimeRange? get selectedRange => _selectedRange;

  void setRange(DateTimeRange? range) {
    if (range == null) {
      _selectedRange = null;
      notifyListeners();
      return;
    }
    final days = range.end.difference(range.start).inDays + 1;
    if (days <= 7) {
      _selectedRange = range;
      notifyListeners();
    }
  }

  Future<void> generateSlots() async {
    _allSlots = [];
    final doctorId = await UserViewModel().getUser();
    List<Map<String, dynamic>> allSlots = [];
    for (int i = 0;
        i <= _selectedRange!.end.difference(_selectedRange!.start).inDays;
        i++) {
      final date = _selectedRange!.start.add(Duration(days: i));
      // for (int i = 0; i < days; i++) {
      String availabilityDate = DateFormat('yy-MM-dd').format(date);
      String ddMonthName = DateFormat('dd MMM').format(date);

      _allSlots.add({
        'availability_date': availabilityDate,
        'timings': [
          {
            'start_time': timeSlots[0]['start_time'],
            'end_time': timeSlots[0]['end_time'],
            'available_flag': 'Y'
          }
        ],
      });

      debugPrint("slots data: $_allSlots");
    }
    notifyListeners();
  }

  toggleSelectedDateAvailability(int index) {
    if (_allSlots[index]['available_flag'] == 'Y') {
      _allSlots[index]['available_flag'] = 'N';
    } else {
      _allSlots[index]['available_flag'] = 'Y';
    }
    debugPrint("${_allSlots[index]['available_flag']}");
    notifyListeners();
  }

  addMoreTimeAtDate(int index, int timeIndex) {
    _allSlots[index]['timing'].add({
      'start_time': timeSlots[timeIndex]['start_time'],
      'end_time': timeSlots[timeIndex]['end_time'],
    });
    notifyListeners();
    print(_allSlots);
  }

  removeTimeAtDate(int index, int timeIndex) {
    _allSlots[index]['timing'].removeAt(timeIndex);
    notifyListeners();
  }

  setAppointmentDuration(String value) {
    _appointmentDuration = value;
    notifyListeners();
  }

  final timeSlots = [
    {'start_time': '08:00 AM', 'end_time': '11:00 AM'},
    {'start_time': '02:00 PM', 'end_time': '04:00 PM'},
    {'start_time': '06:00 PM', 'end_time': '08:00 PM'},
  ];

  Future<void> selectTime(
      BuildContext context, int slotIndex, int timeIndex, String key) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final formatted = DateFormat('hh:mm a').format(
        DateTime(
            now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
      );

      _allSlots[slotIndex]['timing'][timeIndex][key] = formatted;
      // _formattedTime = formatted;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> flattenTimingsWith24HrFormat() {
    final inputFormat = DateFormat.jm();
    final outputFormat = DateFormat.Hm();

    List<Map<String, dynamic>> result = [];

    for (var item in _allSlots) {
      List timings = item['timings'];
      for (var t in timings) {
        final parsedStart = inputFormat.parse(t['start_time']);
        final parsedEnd = inputFormat.parse(t['end_time']);
        result.add({
          'availability_date': item['availability_date'],
          'timings': [
            {
              'start_time': outputFormat.format(parsedStart),
              'end_time': outputFormat.format(parsedEnd),
              'available_flag': 'Y'
            }
          ],
        });
      }
    }
    return result;
  }

  int _widgetIndex = 1;
  int get widgetIndex => _widgetIndex;

  setWidgetIndex(int i) {
    _widgetIndex = i;
    notifyListeners();
  }

  clearSelectedValues() {
    _selectedClinicId = null;
    notifyListeners();
  }

  List<Map<String, dynamic>> _allSlots = [];
  List<Map<String, dynamic>> get allSlots => _allSlots;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  ScheduleDoctorModel? _scheduleDoctorModel;
  ScheduleDoctorModel? get scheduleDoctorModel => _scheduleDoctorModel;
  setDoctorScheduleData(ScheduleDoctorModel value) {
    _scheduleDoctorModel = value;
    notifyListeners();
  }

  Future<void> docScheduleApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {"doctor_id": "6", "clinic_id": _selectedClinicId};
    _docScheduleRepo.docScheduleApi(data).then((value) {
      if (value.status == true) {
        setDoctorScheduleData(value);
        if (value.doctorWorkingHours!.isNotEmpty &&
            value.doctorWorkingHours != []) {
          final lastDate = value.doctorWorkingHours!.last.availabilityDate;
        } else {}
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
    generateSlots();
  }

  setSelectedClinicId(String val) {
    _selectedClinicId = val;
    notifyListeners();
  }

  // List<Map<String, dynamic>> flattenTimings() {
  //   List<Map<String, dynamic>> result = [];
  //
  //   for (var item in _allSlots) {
  //     List timings = item['timing'];
  //     for (var t in timings) {
  //       result.add({
  //         "doctor_id": item["doctor_id"],
  //         "clinic_id": item["clinic_id"],
  //         "availability_date": item["availability_date"],
  //         "dd_month_name": item["dd_month_name"],
  //         "available_flag": item["available_flag"],
  //         "start_time": t["start_time"],
  //         "end_time": t["end_time"],
  //         "doctor_working_hour_id": item['doctor_working_hour_id']
  //       });
  //     }
  //   }
  //
  //   return result;
  // }

  Future<void> docScheduleInsertApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    final schedule = flattenTimingsWith24HrFormat();
    final data = {
      "doctor_id": userId,
      "clinic_id": _selectedClinicId,
      "schedules": schedule
    };
    debugPrint(jsonEncode(data));
    _docScheduleRepo.docInsertScheduleApi(data).then((value) {
      if (value["status"] == true) {
        showInfoOverlay(title: "Success", errorMessage: value['message']);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }
}
