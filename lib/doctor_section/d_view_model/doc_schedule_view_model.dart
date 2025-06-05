import 'package:aim_swasthya/generated/assets.dart';
import 'package:flutter/material.dart';
class ScheduleViewModel extends ChangeNotifier {
  final List<Map<String, dynamic>> scheduleList = [
    {
      "image": Assets.imagesPatientImg,
      "name": "Kartik Mahajan",
      "clnImg": Assets.iconsSolarCalendar,
      "day": "7 June",
      "clockImg": Assets.iconsMdiClock,
      "time": "11:00 PM",
    } ,
    {
      "image": Assets.imagesPatientImg,
      "name": "Anshika Pathak",
      "clnImg": Assets.iconsSolarCalendar,
      "day": "7 June",
      "clockImg": Assets.iconsMdiClock,
      "time": "11:00 PM",
    },
    {
      "image": Assets.imagesPatientImg,
      "name": "Shivani Shinha",
      "clnImg": Assets.iconsSolarCalendar,
      "day": "7 June",
      "clockImg": Assets.iconsMdiClock,
      "time": "11:00 PM",
    },
    {
      "image": Assets.imagesPatientImg,
      "name": "Shivani Shinha",
      "clnImg": Assets.iconsSolarCalendar,
      "day": "7 June",
      "clockImg": Assets.iconsMdiClock,
      "time": "11:00 PM",
    },
  ];
}