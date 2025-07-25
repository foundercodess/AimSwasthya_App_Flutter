// local_db/download_image.dart

import 'dart:io';
import 'package:aim_swasthya/patient_section/p_view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import '../patient_section/view/symptoms/dowenloade_image.dart';
import 'image_db.dart';

class ImageDownloader {
  final Dio _dio = Dio();

  Future<void> fetchAndDownloadImages(BuildContext context,{required String folderName, bool loopAllowed= true, String? fileNames, String? matchName}) async {
    try {
      const String apiUrl = "http://3.7.71.4:3000/getPresignedS3DownloadURIs";

      final Map<String, dynamic> body = {"folderName": folderName};
      print("ghhwdhdvhdvh: ${body}");
      final response = await _dio.post(apiUrl, data: body);

      if (response.statusCode == 200 && response.data['status'] == true) {
        List<dynamic> files = response.data['files'];
        print("ddd: $files");
        if (files.isEmpty) {
          debugPrint("No files to download.");
          return;
        }
        if(loopAllowed==false){
          debugPrint("dmd m dd");
          for(var fileData in files){
            String fileName = fileData['fileName'];
            String presignedUrl = fileData['presignedUrl'];
            debugPrint(fileName);
            debugPrint(fileNames);
            debugPrint("file matched ${(fileName==fileNames)}");
            if(fileName==matchName){
              debugPrint("ddddddk");
              final mimeType = getImageType(fileName);
              debugPrint(mimeType);
              debugPrint("🔽 Downloading: $fileName from $presignedUrl");
              await downloadAndSaveImage(presignedUrl, fileNames!, fileExt: ".$mimeType");
              break;
            }
          }
          return;
        }

        for (var file in files) {
          String fileName = extractName(file['fileName']);
          String presignedUrl = file['presignedUrl'];

          debugPrint("🔽 Downloading: $fileName from $presignedUrl");
          await downloadAndSaveImage(presignedUrl, fileName);
        }
      } else {
        debugPrint("❌ Failed to fetch presigned URLs");
      }
    } catch (e) {
      debugPrint("❗ Error in fetchAndDownloadImages: $e");
    }
  }

  String? getImageType(String fileName) {
    if (fileName.endsWith('.png')) {
      return 'png';
    } else if (fileName.endsWith('.jpg') || fileName.endsWith('.jpeg')) {
      return 'jpg';
    } else if (fileName.endsWith('.pdf')) {
      return 'pdf';
    } else {

      return 'png';
    }
  }

  static Future<void> downloadAndSaveImage(
      String imageUrl, String fileName,{String fileExt='.png'}) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Directory dir = await getApplicationDocumentsDirectory();
        String filePath = "${dir.path}/$fileName$fileExt";
        print("filepath: $filePath");
        File file = File(filePath);

        if (await file.exists()) {
          debugPrint("⚠️ File already exists: $filePath");
          return;
        }

        await file.writeAsBytes(response.bodyBytes);

        await DatabaseHelper.instance.insert({
          "name": fileName,
          "image_path": filePath,
        });

        debugPrint("✅ Image saved: $filePath");
        LocalImageHelper.instance.loadImages();
      } else {
        debugPrint("❌ Failed to download image: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("❗ Error downloading $fileName: $e");
    }
  }

  Future<void> downloadAndSaveDoctorImage(String imageUrl, int id) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        Directory dir = await getApplicationDocumentsDirectory();
        String filePath = "${dir.path}/$id.png";

        File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        await DatabaseHelper.instance.insertDoctor(id, filePath);
        debugPrint("✅ Doctor image saved: $filePath");
      } else {
        debugPrint("❌ Failed to download doctor image");
      }
    } catch (e) {
      debugPrint("❗ "
          "Error in doctor image download: $e");
    }
  }

  static String extractName(String filePath) {
    return filePath.split("/").last.replaceAll(".png", "");
  }
}
