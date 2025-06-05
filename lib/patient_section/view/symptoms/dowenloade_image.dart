import 'dart:async';
import 'package:aim_swasthya/local_db/image_db.dart';
import 'package:flutter/cupertino.dart';

class LocalImageHelper {
  LocalImageHelper._privateConstructor();

  static final LocalImageHelper instance =
      LocalImageHelper._privateConstructor();

  List<Map<String, dynamic>> _images = [];

  final Completer<void> _loadingCompleter = Completer<void>();

  Future<void> get loadingComplete => _loadingCompleter.future;

  Future<void> loadImages() async {
    _images = await DatabaseHelper.instance.fetchAll();
    if (!_loadingCompleter.isCompleted) {
      _loadingCompleter.complete();
    } else {
      debugPrint("future not completed yet");
    }
  }

  Future<void> loadDoctorImages() async {
    _images = await DatabaseHelper.instance.getDoctors();
    _loadingCompleter.complete();
  }

  String? getImagePath(String symptomName) {
    loadImages();
   // final dd= await DatabaseHelper.instance.fetchAll();
    for (var img in _images) {
      if (img['name'] == symptomName) {
        return img['image_path'];
      }
    }
    return null;
  }

  String? getDoctorImagePath(int docId) {
    for (var img in _images) {
      if (img['name'] == docId) {
        return img['image_path'];
      }
    }
    return null;
  }
}
