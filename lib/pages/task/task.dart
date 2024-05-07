import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/pages/task/upload.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';

class TaskController extends GetxController {
  var taskList = ''.obs;
  var isLoading = true.obs;
  var filePaths = [].obs;
  var fileUploadProgress = [].obs;

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
    // Select multiple files
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'mp4'],
    );

    if (results != null) {
      List<File> files = results.paths.map((path) => File(path!)).toList();
      files.forEach((file) {
        filePaths.add(file.path);
      });
    }
  }

  Future<void> uploadFiles() async {
    try {
      filePaths.forEach((file) async {
        final formData = await uploadImage(File(file));
        await dio.post('/files', data: formData,
            onSendProgress: (int sent, int total) {
          final progress = sent / total;
          fileUploadProgress.add(progress);
        });
      });
    } catch (e) {
      print("error upload > $e");
    }
  }

  void removeImage(int index) {
    filePaths.removeAt(index);
  }
}

class TaskAssignment extends StatelessWidget {
  TaskAssignment({super.key});
  final TaskController taskController = Get.find<TaskController>();

  String taskDescription = '';
  @override
  Widget build(BuildContext context) {
    print(taskDescription);

    return Scaffold(
        appBar: AppBar(
          title: Text("Tugas",
              style: GoogleFonts.mulish(
                  fontSize: 24, fontWeight: FontWeight.bold, color: darkText)),
          centerTitle: false,
          titleSpacing: 20,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  await taskController.onUploadTask();
                },
                child: CustomCard(
                    child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.cloud_upload, color: primaryColor),
                        const SizedBox(height: 10),
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
              Obx(() => ListView.builder(
                  itemCount: taskController.filePaths.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          taskController.filePaths[index].split('/').last,
                          style: GoogleFonts.mulish(
                              fontSize: 14,
                              color: darkText,
                              fontWeight: FontWeight.w700)),
                      subtitle: Text(
                          taskController.fileUploadProgress.isEmpty
                              ? 'Belum diupload'
                              : '${(taskController.fileUploadProgress[index] * 100).toStringAsFixed(0)}%',
                          style: GoogleFonts.mulish(
                              fontSize: 12,
                              color: darkText,
                              fontWeight: FontWeight.w400)),
                      trailing: IconButton(
                          onPressed: () {
                            taskController.removeImage(index);
                          },
                          icon: const Icon(Icons.remove_circle_outline,
                              color: Colors.red)),
                    );
                  })),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RoundedButton(
                    text: 'Kirim Tugas',
                    onPressed: () async {
                      await taskController.uploadFiles();
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
