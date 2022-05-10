import 'package:flutter/material.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class WebsitePage extends StatefulWidget {
  const WebsitePage({Key? key}) : super(key: key);

  @override
  State<WebsitePage> createState() => _WebsitePageState();
}

class _WebsitePageState extends State<WebsitePage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('website')),
      body: const WebView(
        initialUrl: 'https://flutter.dev',
      ),
    );
  }
}
