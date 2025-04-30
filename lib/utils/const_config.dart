import 'package:url_launcher/url_launcher.dart';

class Config{
  static const double topSpecialistAverageReview = 3.0;

  static Future<void> launchUrlExternal(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

}
