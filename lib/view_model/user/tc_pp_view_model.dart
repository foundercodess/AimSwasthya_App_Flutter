import 'package:aim_swasthya/repo/user/tc_pp_repo.dart';
import 'package:flutter/cupertino.dart';

class TCPPViewModel extends ChangeNotifier {
  final _tcppRepo = TCPPRepo();
  dynamic _tcData;
  dynamic get tcData => _tcData;
  setTCData(dynamic data) {
    _tcData = data;
    notifyListeners();
  }

  getTC(String type) async {
    setTCData(null);
    await _tcppRepo.tCApi(type).then((res) {
      setTCData(res);
    });
  }
}
