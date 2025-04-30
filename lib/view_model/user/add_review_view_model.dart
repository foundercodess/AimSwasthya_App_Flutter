import 'package:aim_swasthya/repo/user/add_review_repo.dart';
import 'package:aim_swasthya/utils/utils.dart';
import 'package:aim_swasthya/view_model/user/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class AddReviewViewModel extends ChangeNotifier {
  final _addReviewRepo = AddReviewRepo();

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
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
    _addReviewRepo.addReviewApi(data).then((value) {
      Utils.show(value['message'], context);
      if (value['status'] == true) {
        Navigator.of(context).pop();
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print('error: $error');
      }
    });
  }
}
