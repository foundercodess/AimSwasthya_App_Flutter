// patient_section/p_view_model/add_review_view_model.dart
import 'package:aim_swasthya/patient_section/p_repo/add_review_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/patient_section/p_view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'doctor_avl_appointment_view_model.dart';

class AddReviewViewModel extends ChangeNotifier {
  final _addReviewRepo = AddReviewRepo();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  int _ratingValue=4;
  int get ratingValue =>_ratingValue;

  updateRatingValue(int i){
    _ratingValue=i;
    notifyListeners();
  }

  Future<void> addReviewApi(dynamic docId, dynamic rating, dynamic conFor,
      dynamic review, context) async {
    final userId = await UserViewModel().getUser();
    setLoading(true);
    print(docId);
    Map data = {
      "patient_id": userId,
      "doctor_id": docId,
      "rating": rating.toString(),
      "consulted_for": conFor,
      "review": review
    };
    print(data);
    _addReviewRepo.addReviewApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        final docDCon =
        Provider.of<DoctorAvlAppointmentViewModel>(context, listen: false);
        final clinicId = docDCon.doctorAvlAppointmentModel!.data!.clinics![0].clinicId.toString();
        docDCon.doctorAvlAppointmentApi(docId, clinicId, context,clearCon: false);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
