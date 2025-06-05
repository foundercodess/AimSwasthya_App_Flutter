// doctor_section/d_view_model/all_specialization_view_model.dart
import 'package:aim_swasthya/model/doctor/all_specialization_doc_model.dart';
import 'package:aim_swasthya/doctor_section/d_repo/allSpecalization_doc_repo.dart';
import 'package:flutter/foundation.dart';

class AllSpecializationViewModel extends ChangeNotifier {
  final _allSpecializationDocRepo = AllSpecializationDocRepo();
  bool _loading = false;
  bool get loading => _loading;

  AllSpecializationDocModel? _allSpecializationDocModel;
  AllSpecializationDocModel? get allSpecializationDocModel => _allSpecializationDocModel;
  setAllSpecializationDoc(AllSpecializationDocModel value) {
    _allSpecializationDocModel = value;
    notifyListeners();
  }

  String? _selectedSpecializationId;
  String? get selectedSpecializationId=>_selectedSpecializationId;
  setSelectedSpecialization(String data){
    _selectedSpecializationId=data;
    notifyListeners();
  }
  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> docAllSpecializationApi() async {
    setLoading(true);
    _allSpecializationDocRepo.allSpecializationDocApi().then((value) {
      if (value.status == true) {
        setAllSpecializationDoc(value);
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
