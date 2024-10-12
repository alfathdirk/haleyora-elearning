import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/certificate.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/button.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CertifcatePage extends StatefulWidget {
  @override
  _CertificatePageState createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertifcatePage> {
  String pdfPath = "";
  String courseId = Get.parameters['courseId']!;

  final _controller = Completer<PDFViewController>();
  CertificateController certificateController =
      Get.put(CertificateController());

  @override
  void initState() {
    super.initState();
    generateCertificate();
  }

  Future<Uint8List> _getNetworkImage(String url) async {
    final response =
        await dio.get(url, options: Options(responseType: ResponseType.bytes));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load image');
    }
  }

  String getDuration(DateTime startDate, int days) {
    DateTime currentDate = startDate;
    DateTime newDate = currentDate.add(Duration(days: days));
    String formattedDate = DateFormat('dd MMMM yyyy').format(newDate);
    return formattedDate;
  }

  Future<void> generateCertificate() async {
    CertificateData result =
        await certificateController.getCertificateByCourseId(courseId);

    CertificateSetting setting =
        await certificateController.getCertificateSetting();

    final imageBytes = await _getNetworkImage(imageBaseUrl + setting.signature);

    log(result.dateCreated);
    // Data to include in the certificate
    String name = result.employeeName;
    String course = result.courseTitle;
    String expDate = getDuration(
        DateTime.parse(result.dateCreated.toString()), result.expiredDays);
    String createdDate = DateFormat('dd MMMM yyyy')
        .format(DateTime.parse(result.dateCreated.toString()));
    String pic = setting.pic;
    String position = setting.title;

    // String expDate = getDuration(DateTime.now(), 30);
    // String createdDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

    // Create the PDF document
    final pdf = pw.Document();

    // Load the background image (Replace with your actual image)
    // final bgImage = await imageFromAssetBundle('assets/images/pdf.jpg');
    final img = await rootBundle.load('assets/images/pdf.jpg');
    final bgImage = img.buffer.asUint8List();
    // pw.Image image1 = pw.Image(pw.MemoryImage(imageBytes));

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.FullPage(
              ignoreMargins: true,
              child: pw.Stack(
                children: [
                  // Background image
                  pw.Positioned.fill(
                    child: pw.Image(pw.MemoryImage(bgImage),
                        fit: pw.BoxFit.fitHeight),
                  ),
                  // Add certificate text content
                  pw.Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text(
                          'SERTIFIKAT',
                          style: pw.TextStyle(
                            fontSize: 40,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          'Penghargaan',
                          style: pw.TextStyle(
                              fontSize: 16, fontWeight: pw.FontWeight.bold),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 40),
                        pw.Text(
                          'Diberikan kepada:',
                          style: pw.TextStyle(fontSize: 14),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          name,
                          style: pw.TextStyle(
                            fontSize: 32,
                            fontWeight: pw.FontWeight.bold,
                            fontStyle: pw.FontStyle.italic,
                            color: PdfColor.fromHex('#06A3DA'),
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 20),
                        pw.Text(
                          'Telah menyelesaikan Program Kursus Pelatihan,',
                          style: pw.TextStyle(fontSize: 14),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.Text(
                          'yang berjudul:',
                          style: pw.TextStyle(fontSize: 14),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 30),
                        pw.SizedBox(
                          width: 300,
                          child: pw.Text(
                            course,
                            style: pw.TextStyle(
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                            textAlign: pw.TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                        pw.SizedBox(height: 30),
                        pw.Text(
                          'pada tanggal $createdDate.',
                          style: pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 35),
                        pw.Text(
                          'Sertifikat ini berlaku sampai dengan tanggal:',
                          style: pw.TextStyle(
                              fontSize: 12, fontStyle: pw.FontStyle.italic),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 10),
                        pw.Text(
                          expDate,
                          style: pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.center,
                        ),
                        pw.SizedBox(height: 130),
                        pw.Text(
                          position,
                          style: pw.TextStyle(
                            fontSize: 16,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                          maxLines: 2,
                        ),
                        pw.SizedBox(height: 60),
                        // add image signature
                        pw.Image(pw.MemoryImage(imageBytes),
                            width: 100, height: 100),
                        pw.SizedBox(height: 30),
                        pw.Text(
                          pic,
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                          textAlign: pw.TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ));
        },
      ),
    );

    var output = await getApplicationDocumentsDirectory();
    final file = File('${output.path}/certificate-$course.pdf');
    await file.writeAsBytes(await pdf.save());

    print(output.path);

    setState(() {
      pdfPath = file.path;
    });

    // Open the PDF in the device's PDF viewer
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sertifikat'),
      ),
      body: Center(
        child: pdfPath == ""
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  PDFView(
                    filePath: pdfPath,
                    onViewCreated: (PDFViewController pdfViewController) {
                      _controller.complete(pdfViewController);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: RoundedButton(
                          text: 'Download',
                          onPressed: () {
                            print('download');

                            Permission.storage.request().then((value) {
                              if (!value.isGranted) {
                                Get.showSnackbar(
                                  const GetSnackBar(
                                    title: 'Error',
                                    message: 'Izin akses penyimpanan ditolak!',
                                    icon: Icon(Icons.info_outline),
                                    duration: Duration(seconds: 3),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              Get.showSnackbar(
                                const GetSnackBar(
                                  title: 'Success',
                                  message: 'Sertifikat berhasil didownload!',
                                  icon: Icon(Icons.info_outline,
                                      color: Colors.white),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              File(pdfPath).copy(
                                  '/storage/emulated/0/Download/certificate.pdf');
                            }).catchError((onError) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  title: 'Error',
                                  message: 'Gagal mendownload sertifikat!',
                                  icon: Icon(Icons.info_outline),
                                  duration: Duration(seconds: 3),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            });
                          }),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
