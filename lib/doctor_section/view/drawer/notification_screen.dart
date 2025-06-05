// doctor_section/view/drawer/notification_screen.dart
import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:aim_swasthya/utils/load_data.dart';
import 'package:aim_swasthya/utils/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/view_model/notification_view_model.dart';
import '../../../model/doctor/notification_model.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<NotificationViewModel>(context, listen: false)
          .fetchNotifications(type: 'doctor');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<NotificationViewModel>(
        builder: (context, viewModel, child) {
          final notifications = viewModel.notificationModel?.data ?? [];
          final today = DateTime.now();
          final todayList = notifications.where((n) {
            if (n.sentAt == null) return false;
            final sentDate = _parseDate(n.sentAt!);
            return sentDate != null &&
                sentDate.year == today.year &&
                sentDate.month == today.month &&
                sentDate.day == today.day;
          }).toList();
          final allList = notifications.where((n) {
            if (n.sentAt == null) return false;
            final sentDate = _parseDate(n.sentAt!);
            return sentDate == null ||
                !(sentDate.year == today.year &&
                    sentDate.month == today.month &&
                    sentDate.day == today.day);
          }).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppbarConst(title: 'Notifications'),
              Expanded(
                child: viewModel.loading
                    ? const Scaffold(
                        body: LoadData(),
                      )
                    : ListView(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        children: [
                          if (todayList.isNotEmpty) ...[
                            _sectionHeader('Today'),
                            ...todayList.map(
                                (n) => _notificationTile(n, highlight: true)),
                          ],
                          if (allList.isNotEmpty) ...[
                            _sectionHeader('All notifications'),
                            ...allList.map((n) => _notificationTile(n)),
                          ],
                          if (notifications.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Center(
                                  child: NoDataMessages(image:
                                    Image.asset(Assets.iconsNotification,
                                        height: Sizes.screenHeight * 0.03,
                                        width: Sizes.screenHeight * 0.03),
                                    // image: AssetImage(Assets.iconsNotification,),
                                message: "All quiet here",
                                title:
                                    "You’ll receive updates here when\nsomething needs your attention",
                              )),
                            ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextConst(title,
              fontWeight: FontWeight.w400, size: Sizes.fontSizeFivePFive),
          Row(
            children: [
              TextConst('Sort', color: Colors.grey),
              const Icon(Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey, size: 18),
            ],
          ),
        ],
      ),
    );
  }

  Widget _notificationTile(NotificationData n, {bool highlight = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: highlight ? const Color(0xFFEAF6FF) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextConst(
            n.title ?? '',
            fontWeight: FontWeight.w400,
            size: Sizes.fontSizeFive,
          ),
          const SizedBox(height: 4),
          TextConst(
            n.message ?? '',
            size: Sizes.fontSizeFour,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  DateTime? _parseDate(String dateStr) {
    try {
      // Example: '2025-04-06 09:45 PM'
      return DateTime.parse(
          dateStr.replaceAll(' PM', '').replaceAll(' AM', ''));
    } catch (_) {
      return null;
    }
  }
}
