import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/popup.dart';

class UploadController extends GetxController {
  var file = ''.obs;
}

class TaskAssignment extends StatelessWidget {
  const TaskAssignment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tugas",
              style: GoogleFonts.mulish(
                  fontSize: 24, fontWeight: FontWeight.bold, color: darkText)),
          centerTitle: false,
          titleSpacing: 20,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                  'Jelaskan bagaimana cara penanganan kabel incoming (Trafo - PHB TR )/outgoing TR yang benar with long text, Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur',
                  style: GoogleFonts.mulish(
                      fontSize: 16,
                      color: darkText,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              RichText(
                  text: TextSpan(
                      text:
                          'Silahkan upload tugas Anda pada tautan dibawah ini. Format dalam bentuk ',
                      style: GoogleFonts.mulish(
                        fontSize: 12,
                        color: darkText,
                      ),
                      children: [
                    TextSpan(
                      text: 'PDF, JPG, PNG dan Mp4.',
                      style: GoogleFonts.mulish(
                          fontSize: 12,
                          color: darkText,
                          fontWeight: FontWeight.bold),
                    )
                  ])),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['jpg', 'pdf', 'doc', 'png', 'mp4'],
                  );
                },
                child: CustomCard(
                    child: Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.cloud_upload, color: primaryColor),
                        SizedBox(height: 10),
                        Text('Ketuk disini untuk mengupload tugas.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: darkText)),
                      ],
                    ),
                  ),
                )),
              ),
            ],
          ),
        ));
  }
}
