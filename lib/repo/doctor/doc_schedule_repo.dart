// repo/doctor/doc_schedule_repo.dart
import 'package:aim_swasthya/helper/network/network_api_services.dart';
import 'package:aim_swasthya/model/doctor/doc_schedule_model.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:flutter/foundation.dart';

class DocScheduleRepo {
  final _apiServices = NetworkApiServices();

  Future<ScheduleDoctorModel> docScheduleApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.scheduleDoctor, data);
      return ScheduleDoctorModel.fromJson(response);

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docScheduleApi: $e');
      }
      rethrow;
    }
  }

  Future<dynamic> docInsertScheduleApi(dynamic data) async {
    try {
      dynamic response =
      await _apiServices.getPostApiResponse(DoctorApiUrl.upsertScheduleDoctor, data);
      return response;

    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docInsertScheduleApi: $e');
      }
      rethrow;
    }
  }
    Future<dynamic> docScheduleSlotTypeApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostApiResponse(DoctorApiUrl.upsertScheduleSlotTypeDoctor, data);
      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred during docScheduleSlotTypeApi: $e');
      }
      rethrow;
    }
  }
}