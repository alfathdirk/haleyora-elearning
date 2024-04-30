import 'dart:convert';
// import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class PDF {
  static Future<void> generate() async {
    final img = await rootBundle.load('assets/images/pdf.png');
    final imageBytes = img.buffer.asUint8List();
    pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Container(
            alignment: pw.Alignment.center,
            height: double.infinity,
            child: image1,
          );
        },
      ),
    );
    var savedFile = await pdf.save();
    List<int> fileInts = List.from(savedFile);
    html.AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(fileInts)}")
      ..setAttribute("download", "${DateTime.now().millisecondsSinceEpoch}.pdf")
      ..click();
    // final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());
  }
}
