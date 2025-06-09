// view_model/user/userRegisterCon.dart
import 'package:flutter/foundation.dart';

class UserRoleViewModel extends ChangeNotifier {
  // Navigation type (1 for login, 2 for signup)
  int _navType = 1;
  int get navType => _navType;

  // User role (1 for default role)
  int _userRole = 1;
  int get userRole => _userRole;

  // Personal info selection
  int _isPersonalInfoSelected = 1;
  int get isPersonalInfoSelected => _isPersonalInfoSelected;

  // Set navigation type (login/signup)
  setNavType(int value) {
    _navType = value;
    print("etted nav type: $_navType");
    notifyListeners();
  }

  // Set user role
  setUserRole(int value) {
    _userRole = value;
    if (kDebugMode) {
      print("User Role: $value");
    }
    notifyListeners();
  }

  // Change widget selection
  changeWidget(int value) {
    _isPersonalInfoSelected = value;
    notifyListeners();
  }

  // Reset all values to default
  resetValues() {
    _isPersonalInfoSelected = 1;
    // _navType = 1;
    // _userRole = 1;
    notifyListeners();
  }

  // Dispose key
  disposeKey() {
    _isPersonalInfoSelected = 1;
    _navType = 1;
    _userRole = 1;
    notifyListeners();
  }
}
