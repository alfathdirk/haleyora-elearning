import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/card.dart';

class TaskController extends GetxController {
  var taskList = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    final id = Get.parameters['id'];
    print(id);
    // fetchTask(id!);
    super.onInit();
  }

  void fetchTask(String id) async {
    try {
      isLoading(true);
      // CourseData task = await dio.get('/items/course/${id}');
    } finally {
      isLoading(false);
    }
  }

  Future<void> onUploadTask() async {
    List<String> filePaths = [];

    // Select multiple files
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'mp4'],
    );

    if (results != null) {
      List<File> files = results.paths.map((path) => File(path!)).toList();
      print(files);
    }
  }
}

class TaskAssignment extends StatelessWidget {
  TaskAssignment({super.key});
  String taskDescription = '';
  @override
  Widget build(BuildContext context) {
    print(taskDescription);

    final TaskController taskController = Get.put(TaskController());
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
                  taskDescription.isEmpty
                      ? 'Tidak ada deskripsi tugas.'
                      : taskDescription,
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
                  await taskController.onUploadTask();
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
