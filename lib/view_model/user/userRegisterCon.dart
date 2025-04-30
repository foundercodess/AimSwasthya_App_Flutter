// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
//
// class UserRegisterViewModel extends ChangeNotifier {
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//
//   int _isPersonalInfoSelected = 1;
//
//   int get isPersonalInfoSelected => _isPersonalInfoSelected;
//
//   int _userRole = 1;
//
//   int get userRole => _userRole;
//
//   setUserRole(int value) {
//     _userRole = value;
//     if (kDebugMode) {
//       print("$value   $_userRole");
//     }
//     notifyListeners();
//   }
//
//   changeWidget(int value) {
//     _isPersonalInfoSelected = value;
//     notifyListeners();
//   }
//   resetValues(){
//     _isPersonalInfoSelected = 1;
//     notifyListeners();
//   }
//
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserRegisterViewModel extends ChangeNotifier {
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  int _isPersonalInfoSelected = 1;

  int get isPersonalInfoSelected => _isPersonalInfoSelected;

  int _userRole = 1;

  int get userRole => _userRole;

  setUserRole(int value) {
    _userRole = value;
    if (kDebugMode) {
      print("$value   $_userRole");
    }
    notifyListeners();
  }

  changeWidget(int value) {
    _isPersonalInfoSelected = value;
    notifyListeners();
  }

  resetValues() {
    _isPersonalInfoSelected = 1;
    notifyListeners();
  }

  // Method to dispose the GlobalKey when needed
  disposeKey() {
    // Dispose of the Scaffold key if it has a current state
    // if (scaffoldKey.currentState != null) {
    //   scaffoldKey.currentState?.dispose();
    // }
  }
}
