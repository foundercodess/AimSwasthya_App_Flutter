import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkChecker {
  /// Returns `true` if device has internet access (Wi-Fi/Mobile + actual connectivity)
  static Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // No network interface is available
      return false;
    }

    // Now check for actual internet access
    return await InternetConnectionChecker.instance.hasConnection;
  }
}
