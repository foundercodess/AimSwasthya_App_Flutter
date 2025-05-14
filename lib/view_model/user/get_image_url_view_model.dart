import 'dart:io';
import 'package:aim_swasthya/view_model/user/patient_medical_records_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:aim_swasthya/res/api_urls.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:mime/mime.dart';
import 'package:provider/provider.dart';
import '../../repo/user/get_image_url_repo.dart';
import 'package:http/http.dart' as http;

class GetImageUrlViewModel extends ChangeNotifier {
  final Dio _dio = Dio();

  final _addMedicalRecord = GetImageUrlRepo();

  bool _isImageUploaded = false;
  bool get isImageUploaded => _isImageUploaded;
  setImageUploading(bool val) {
    _isImageUploaded = val;
    notifyListeners();
  }

  Future<bool?> addMedicalRecord(
      BuildContext context,
      {required String filePath, required String fileName}) async {
    final userId = await UserViewModel().getUser();
    String fileType;

    if (filePath.endsWith('.png') ||
        filePath.endsWith('.jpg') ||
        filePath.endsWith('.jpeg')) {
      fileType = 'image';
    }else if (filePath.endsWith('.pdf')) {
      fileType = 'pdf';
    } else {
      fileType = 'document';
    }
    final dataPayload = {
      "entity_id": userId,
      "entity_type": "patient",
      "image_name": "$fileName.$fileType"
    };
    print('ddyload: $dataPayload');
    try {
      final value = await _addMedicalRecord.addMedicalRecordApi(dataPayload);
      debugPrint("response data: $value");

      if (value['status'] == true) {
        uploadFile(context,fileName: value['image_url'], filePath: filePath);
        return true;
      } else {
        debugPrint("status false ${value['message']}");
        return false;
      }
    } catch (err) {
      debugPrint("error occurred during add Medical record api: $err");
      return false;
    }
    // await _addMedicalRecord.addMedicalRecordApi(dataPayload).then((value) {
    //   debugPrint("response data: $value");
    //   if (value['status'] == true) {
    //     uploadFile(fileName: value['image_url'], filePath: filePath);
    //   } else {
    //     debugPrint("status false ${value['message']}");
    //   }
    //   return value['status'];
    // }).catchError((err) {
    //   debugPrint("error occurred during add Medical record api: $err");
    //   return false;
    // });
  }

  Future<void> uploadFile( BuildContext context,
      {required String filePath, required String fileName}) async {
    if (filePath.isEmpty) return;
    final bearerToken = await UserViewModel().getBeToken();

    String fileType;

    if (filePath.endsWith('.png') ||
        filePath.endsWith('.jpg') ||
        filePath.endsWith('.jpeg')) {
      fileType = 'image';
    } else if (filePath.endsWith('.mp4') || filePath.endsWith('.mov')) {
      fileType = 'video';
    } else if (filePath.endsWith('.pdf')) {
      fileType = 'pdf';
    } else {
      fileType = 'document';
    }

    final payload = {
      "fileName": fileName,
      "fileType": "application/$fileType",
    };
    try {
      final response = await _dio.post(
        PatientApiUrl.getImageUrl,
        options: Options(headers: {
          "Authorization": "Bearer $bearerToken",
          "Content-Type": "application/json",
        }),
        data: payload,
      );

      final data = response.data;
      debugPrint("🔍 API Response: $data");

      if (response.statusCode == 200 && data['status'] == true) {
        final preSignedUrl = data['presigned_url'];
        final fileUrl = data['file_url'];
        uploadImageToS3(context,
            filePath: filePath, preSignedUrl: preSignedUrl, fileName: fileName);
      } else {
        debugPrint("❌ Failed to get preSigned URL: ${response.data}");
      }
    } catch (e) {
      debugPrint("❗ Exception during upload: $e");
    }
  }

  Future<void> uploadImageToS3( BuildContext context,
      {required String filePath,
      required String preSignedUrl,
      String? fileName}) async {
    print(filePath);
    print(preSignedUrl);
    print(fileName);
    try {
      final file = File(filePath);
      final fileBytes = await file.readAsBytes();
      final mimeType = lookupMimeType(filePath) ?? 'application/octet-stream';
      final headers = {
        'Content-Type': mimeType,
        'Content-Disposition': 'inline; filename="$fileName"',
      };
      final response = await http.put(
        Uri.parse(preSignedUrl),
        headers: headers,
        body: fileBytes,
      );

      if (response.statusCode == 200) {
        debugPrint('✅ Upload successful!');
        Provider.of<PatientMedicalRecordsViewModel>(context, listen: false)
            .patientMedRecApi();
      } else {
        debugPrint(
            '❌ Upload failed with status: ${response.statusCode} || Response body: ${response.body}');
      }
    } catch (e) {
      debugPrint('❗ Error uploading: $e');
    }
  }
}
