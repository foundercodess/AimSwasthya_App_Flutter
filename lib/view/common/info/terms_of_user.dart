import 'package:aim_swasthya/utils/load_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';

import '../../../res/appbar_const.dart';
import '../../../view_model/user/tc_pp_view_model.dart';

class TermsOfUserScreen extends StatefulWidget {
  final String type;
  const TermsOfUserScreen({super.key, required this.type});

  @override
  State<TermsOfUserScreen> createState() => _TermsOfUserScreenState();
}

class _TermsOfUserScreenState extends State<TermsOfUserScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TCPPViewModel>(context, listen: false).getTC(widget.type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TCPPViewModel>(builder: (context, tcCon, _) {
      if (tcCon.tcData == null) {
        return const Scaffold(body: Center(child: LoadData()));
      }
      final heading = tcCon.tcData['headings'];
      final body = tcCon.tcData['data'];
      return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AppbarConst(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                title: '',
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: HtmlWidget(body),
              )
            ],
          ),
        ),
      );
    });
  }
}
