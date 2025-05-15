import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:flutter/material.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          AppbarConst(
            title: 'Notifications',
          ),

        ],
      ),
    );
  }
}
