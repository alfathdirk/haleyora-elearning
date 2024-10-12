import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PDFscreen extends StatefulWidget {
  @override
  _PDFscreenState createState() => _PDFscreenState();
}

class _PDFscreenState extends State<PDFscreen> {
  late final WebViewController controller;
  final path = Get.arguments['path'];

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(
      Uri.parse(path),
    );
    // make the orientation landscape when open pdf
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    // make the orientation portrait when close pdf
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Baca Materi'),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
