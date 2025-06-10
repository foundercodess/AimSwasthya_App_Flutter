import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker {
  /// Returns `true` if device has internet access (Wi-Fi/Mobile + actual connectivity)
  static Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No Wi-Fi or mobile connection
      return false;
    }

    // Check if the device can actually reach the internet
    return await InternetConnectionChecker().hasConnection;
  }
}