import 'package:aim_swasthya/res/appbar_const.dart';
import 'package:aim_swasthya/res/common_material.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebViewScreen extends StatelessWidget {
  final String url;
  final String? title;

  const ArticleWebViewScreen({super.key, required this.url, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: TextConst(title ?? 'Keeping you healthy'),
      // ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppbarConst(title: "Keeping you healthy"),
          Expanded(
            child: WebViewWidget(
              controller: WebViewController()
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..loadRequest(Uri.parse(url)),
            ),
          ),
        ],
      ),
    );
  }
} 