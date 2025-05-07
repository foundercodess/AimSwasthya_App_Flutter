// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:aim_swasthya/helper/app_exception.dart';
import 'package:aim_swasthya/helper/network/base_api_services.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../utils/show_server_error.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    final token = await UserViewModel().getBeToken();
    print(token);
    dynamic responseJson;
    try {
      final response = await http.get(headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      }, Uri.parse(url)).timeout(const Duration(minutes: 10));
      if (kDebugMode) {
        print('Api Url : $url');
      }
      responseJson = returnRequest(response);
    } on SocketException {
      showInfoOverlay(
          title: "No Internet",
          errorMessage:
              "Internet connection not found! Please check your network settings.");
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    final token = await UserViewModel().getBeToken();
    print(token);
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url),
              headers: {
                'Authorization': 'Bearer $token',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(data))
          .timeout(const Duration(minutes: 10));
      if (kDebugMode) {
        print('Api Url : $url');
      }
      responseJson = returnRequest(response);
    } on SocketException {
      showInfoOverlay(
          title: "No Internet",
          errorMessage:
              "Internet connection not found! Please check your network settings and try again.");
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnRequest(response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('response 200: $responseJson');
        }
        return responseJson;
      case 400:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('response 400: $responseJson');
        }
        return responseJson;
      // throw BadRequestException(response.body.toString());
      case 404:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('response 404: $responseJson');
        }
        // showInfoOverlay(statusCode: response.statusCode);
        return responseJson;
      // throw UnauthorisedException(response.body.toString());
      case 500:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('response 500: $responseJson');
        }
        showInfoOverlay(statusCode: response.statusCode);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        if (kDebugMode) {
          print('response 201: $responseJson');
        }
        return responseJson;
      default:
        showInfoOverlay(statusCode: response.statusCode);
        throw FetchDataException(
            'Error accrued while communicating with server with status code${response.statusCode}');
    }
  }
}
