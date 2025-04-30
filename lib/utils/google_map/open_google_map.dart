import 'package:url_launcher/url_launcher.dart';

Future<void> openGoogleMap(double destinationLat, double destinationLng) async {
  final Uri url = Uri.parse(
    'https://www.google.com/maps/dir/?api=1&destination=$destinationLat,$destinationLng&travelmode=driving&dir_action=navigate',
  );

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch Google Maps';
  }
}