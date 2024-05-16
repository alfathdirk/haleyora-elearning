import 'dart:developer';

import 'package:flutter/material.dart';
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
    log(path);
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(path),
      );
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
