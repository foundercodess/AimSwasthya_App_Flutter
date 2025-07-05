// patient_section/p_view_model/slot_schedule_view_model.dart
import 'dart:convert';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/res/color_const.dart';
import 'package:aim_swasthya/utils/routes/routes_name.dart';
import 'package:aim_swasthya/utils/show_server_error.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/doctor/doc_schedule_model.dart';
import '../../doctor_section/d_repo/doc_schedule_repo.dart';

class SlotScheduleViewModel extends ChangeNotifier {
  SlotScheduleViewModel() {
    DateTime now = DateTime.now();
    _selectedRange = DateTimeRange(
      start: now,
      end: now.add(const Duration(days: 6)),
    );
  }

  String getFullWeekdayName(String shortName) {
    // Create a date for Monday (1) to Sunday (7)
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final index = weekdays.indexOf(shortName);
    if (index == -1) return shortName;

    // Create a date for the corresponding weekday
    final now = DateTime.now();
    final daysUntilMonday = (DateTime.monday - now.weekday) % 7;
    final monday = now.add(Duration(days: daysUntilMonday));
    final targetDate = monday.add(Duration(days: index));

    // Format the date to get full weekday name
    return DateFormat('EEEE').format(targetDate);
  }

  final _docScheduleRepo = DocScheduleRepo();
  bool _loading = false;
  bool get loading => _loading;
  final appointmentDurationList = [
    {"value": '15_MINUTES', "label": '15 min'},
    {"value": '30_MINUTES', "label": '30 min'}
  ];
  String? _selectedClinicId;
  String? get selectedClinicId => _selectedClinicId;
  String _appointmentDuration = '15_MINUTES';
  String get appointmentDuration => _appointmentDuration;
  String? _slotType = 'weekly';
  String? get slotType => _slotType;

  DateTimeRange? _selectedRange;

  DateTimeRange? get selectedRange => _selectedRange;

  setSlotType(String value) {
    _slotType = value;
    notifyListeners();
  }

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

    if (_slotType == "indefinitely") {
      DateTime currentDate = DateTime.now();
      int daysUntilMonday = (DateTime.monday - currentDate.weekday) % 7;
      DateTime mondayDate = currentDate.add(Duration(days: daysUntilMonday));

      for (int i = 0; i < 7; i++) {
        final date = mondayDate.add(Duration(days: i));
        String availabilityDate = DateFormat('yy-MM-dd').format(date);
        String dayName = DateFormat('EEE').format(date);
        String ddMonthName = dayName;

        print("Checking indefinitely - availabilityDate: $availabilityDate");
        print(
            "Available dates in model: ${scheduleDoctorModel?.schedules?.map((e) => e.availabilityDate).toList()}");

        final existingIndex =
            scheduleDoctorModel?.schedules?.indexWhere((element) {
          print(
              "Comparing indefinitely - element.availabilityDate: ${element.availabilityDate} with availabilityDate: $availabilityDate");
          return element.availabilityDate == availabilityDate;
        });
        if (existingIndex != null && existingIndex != -1) {
          List<Timings>? timings =
              scheduleDoctorModel?.schedules?[existingIndex].timings;
          if (timings != null && timings.isNotEmpty) {
            _allSlots.add({
              'availability_date': scheduleDoctorModel
                  ?.schedules?[existingIndex].availabilityDate,
              'dd_month_name':
                  scheduleDoctorModel?.schedules?[existingIndex].ddMonthName,
              'available_flag':
                  scheduleDoctorModel?.schedules?[existingIndex].availableFlag,
              'timings': timings
                  .map((t) => {
                        'start_time': t.startTime,
                        'end_time': t.endTime,
                      })
                  .toList()
            });
          }
        } else {
          _allSlots.add({
            'availability_date': availabilityDate,
            'dd_month_name': ddMonthName,
            'available_flag': 'Y',
            'timings': [
              {
                'start_time': timeSlots[0]['start_time'],
                'end_time': timeSlots[0]['end_time'],
              }
            ],
          });
        }
      }
    } else {
      // Original range-based logic
      if (_selectedRange != null) {
        for (int i = 0;
            i <= _selectedRange!.end.difference(_selectedRange!.start).inDays;
            i++) {
          final date = _selectedRange!.start.add(Duration(days: i));
          String availabilityDate = DateFormat('yy-MM-dd').format(date);
          String availabilityDateM = DateFormat('dd-MM-yyyy').format(date);
          String dayName = DateFormat('EEE').format(date);
          String ddMonthName = DateFormat('dd MMM').format(date);

          print("Checking range - availabilityDateM: $availabilityDateM");
          print(
              "Available dates in model: ${scheduleDoctorModel?.schedules?.map((e) => e.availabilityDate).toList()}");

          final existingIndex =
              scheduleDoctorModel?.schedules?.indexWhere((element) {
            print(element.availabilityDate == availabilityDateM);
            print(
                "Comparing range - element.availabilityDate: ${element.availabilityDate} with availabilityDateM: $availabilityDateM");
            return element.availabilityDate == availabilityDateM;
          });
          if (existingIndex != null && existingIndex != -1) {
            List<Timings>? timings =
                scheduleDoctorModel?.schedules?[existingIndex].timings;
            print("timings: $timings");
            if (timings != null && timings.isNotEmpty) {
              _allSlots.add({
                'availability_date': scheduleDoctorModel
                    ?.schedules?[existingIndex].availabilityDate,
                'dd_month_name':
                    scheduleDoctorModel?.schedules?[existingIndex].ddMonthName,
                'available_flag': scheduleDoctorModel
                    ?.schedules?[existingIndex].availableFlag,
                'timings': timings
                    .map((t) => {
                          'start_time': t.startTime,
                          'end_time': t.endTime,
                        })
                    .toList()
              });
            }
          } else {
            _allSlots.add({
              'availability_date': availabilityDateM,
              'dd_month_name': ddMonthName,
              'available_flag': 'Y',
              'timings': [
                {
                  'start_time': timeSlots[0]['start_time'],
                  'end_time': timeSlots[0]['end_time'],
                }
              ],
            });
          }
        }
      }
    }

    debugPrint("slots data: $_allSlots");
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
    _allSlots[index]['timings'].add({
      'start_time': timeSlots[timeIndex]['start_time'],
      'end_time': timeSlots[timeIndex]['end_time'],
    });
    notifyListeners();
    debugPrint(_allSlots.toString());
  }

  removeTimeAtDate(int index, int timeIndex) {
    _allSlots[index]['timings'].removeAt(timeIndex);
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
    if (slotIndex >= 0 && slotIndex < _allSlots.length) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child){
          return Theme(data: Theme.of(context).copyWith(
            timePickerTheme: const TimePickerThemeData(
              dialBackgroundColor: AppColor.purple,
              dialTextColor: AppColor.white,
              dayPeriodTextColor: AppColor.textGrayColor,
              dayPeriodColor: AppColor.purple,
            )
          ), child: child!);
        }
      );
      if (pickedTime != null) {
        final now = DateTime.now();
        final formatted = DateFormat('hh:mm a').format(
          DateTime(
              now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
        );

        if (_allSlots[slotIndex]['timings'] != null &&
            timeIndex < _allSlots[slotIndex]['timings'].length) {
          _allSlots[slotIndex]['timings'][timeIndex][key] = formatted;
          notifyListeners();
        }
      }
    }
  }

  List<Map<String, dynamic>> flattenTimingsWith24HrFormat() {
    final inputFormat = DateFormat.jm();
    final outputFormat = DateFormat.Hm();

    List<Map<String, dynamic>> result = [];

    for (var item in _allSlots) {
      List timings = item['timings'];
      List<Map<String, String>> formattedTimings = [];

      for (var t in timings) {
        final parsedStart = inputFormat.parse(t['start_time']);
        final parsedEnd = inputFormat.parse(t['end_time']);

        formattedTimings.add({
          'start_time': outputFormat.format(parsedStart),
          'end_time': outputFormat.format(parsedEnd),
        });
      }

      if (_slotType == "weekly") {
        // Convert date from DD-MM-YYYY to YYYY-MM-DD
        final dateParts = item['availability_date'].split('-');
        final formattedDate = '${dateParts[2]}-${dateParts[1]}-${dateParts[0]}';

        result.add({
          'availability_date': formattedDate,
          'available_flag': item['available_flag'],
          'timings': formattedTimings,
        });
      } else {
        // For indefinite schedule, use working_day instead of availability_date
        final weekdayName = getFullWeekdayName(item['dd_month_name']);
        result.add({
          'working_day': weekdayName,
          'available_flag': item['available_flag'],
          'timings': formattedTimings,
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
    _widgetIndex = 1;
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
    if (value.schedules != null && value.schedules!.isNotEmpty) {
      try {
        // Set slot type from API response
        if (value.slotType != null && value.slotType!.isNotEmpty) {
          _slotType = value.slotType![0].scheduleType;
          _appointmentDuration = value.slotType![0].slotType ?? '15_MINUTES';
        }

        // Convert dates from DD-MM-YYYY to DateTime objects
        final startDateParts =
            value.schedules!.first.availabilityDate?.split('-') ?? [];
        final endDateParts =
            value.schedules!.last.availabilityDate?.split('-') ?? [];

        if (startDateParts.length == 3 && endDateParts.length == 3) {
          final formattedStartDate =
              '${startDateParts[2]}-${startDateParts[1]}-${startDateParts[0]}';
          final formattedEndDate =
              '${endDateParts[2]}-${endDateParts[1]}-${endDateParts[0]}';

          _selectedRange = DateTimeRange(
              start: DateTime.parse(formattedStartDate),
              end: DateTime.parse(formattedEndDate));
        }

        // Set up _allSlots with the schedule data
        _allSlots = value.schedules!.map((schedule) {
          return {
            'availability_date': schedule.availabilityDate,
            'dd_month_name': schedule.ddMonthName,
            'available_flag': schedule.availableFlag,
            'timings': schedule.timings
                    ?.map((timing) => {
                          'start_time': timing.startTime,
                          'end_time': timing.endTime,
                        })
                    .toList() ??
                [],
          };
        }).toList();

        // Original code (backup)
        // final startDateParts = value.schedules!.first.availabilityDate?.split('-') ?? [];
        // final endDateParts = value.schedules!.last.availabilityDate?.split('-') ?? [];
        // if (startDateParts.length == 3 && endDateParts.length == 3) {
        //   final formattedStartDate = '${startDateParts[2]}-${startDateParts[1]}-${startDateParts[0]} 00:00:00';
        //   final formattedEndDate = '${endDateParts[2]}-${endDateParts[1]}-${endDateParts[0]} 00:00:00';
        //   _selectedRange = DateTimeRange(
        //     start: DateTime.parse(formattedStartDate),
        //     end: DateTime.parse(formattedEndDate)
        //   );
        // }
      } catch (e) {
        debugPrint('Error parsing dates: $e');
      }
    }
    notifyListeners();
  }

  Future<void> docScheduleApi() async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    Map data = {"doctor_id": userId.toString(), "clinic_id": _selectedClinicId};
    print("ijfeiorjfio${jsonEncode(data)}");
    _docScheduleRepo.docScheduleApi(data).then((value) {
      if (value.status == true) {
        setDoctorScheduleData(value);
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

  Future<void> docScheduleSlotTypeApi(BuildContext context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    final data = {
      "doctor_id": userId,
      "clinic_id": _selectedClinicId,
      "slot_type": _appointmentDuration,
      "schedule_type": _slotType,
      "available_flag": "Y"
    };
    _docScheduleRepo.docScheduleSlotTypeApi(data).then((value) {
      if (value["status"] == true) {
        Utils.show(value['message'], context);
        generateSlots();
        setWidgetIndex(3);
      }
      setLoading(false);
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
      setLoading(false);
    });
  }

  Future<void> docScheduleInsertApi(BuildContext context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    final schedule = flattenTimingsWith24HrFormat();
    final data = {
      "doctor_id": int.parse(userId.toString()),
      "clinic_id": int.parse(_selectedClinicId ?? "0"),
      "schedules": schedule
    };
    debugPrint("insert data: ${jsonEncode(data)}");
    _docScheduleRepo
        .docInsertScheduleApi(
            data,
            _slotType == 'weekly'
                ? DoctorApiUrl.upsertScheduleDoctor
                : DoctorApiUrl.upsertIndefiniteScheduleDoctor)
        .then((value) {
      if (value["status"] == true) {
        docScheduleApi();
        // showInfoOverlay(title: "Success", errorMessage: value['message']);
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.doctorBottomNevBar, (context)=>false, arguments: true);
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
