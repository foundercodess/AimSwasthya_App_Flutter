import 'package:flutter/foundation.dart';

class RegisterViewModel extends ChangeNotifier {
  bool _isPersonalInfoSelected = true;

  bool get isPersonalInfoSelected => _isPersonalInfoSelected;

  changeWidget(bool value) {
    _isPersonalInfoSelected = value;
    notifyListeners();
  }
  resetValues(){
    _isPersonalInfoSelected = true;
    notifyListeners();
  }
}