import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/pages/task/upload.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';

class TaskController extends GetxController {
  var taskList = ''.obs;
  var isLoading = true.obs;
  var filePaths = [].obs;
  var fileUploadProgress = [].obs;
  var loadingUpload = false.obs;

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

  Future<void> onUploadTask(String courseId) async {
    try {
      AuthController authController = Get.find<AuthController>();
      CourseController courseController = Get.find<CourseController>();
      FilePickerResult? results = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png', 'mp4'],
      );

      if (results != null) {
        loadingUpload.value = true;

        List<String> ids = [];
        List<File> files = results.paths.map((path) => File(path!)).toList();
        await Future.forEach(files, (file) async {
          filePaths.add(file.path);
          fileUploadProgress.add(0.0);
          final formData = await uploadImage(File(file.path));
          final result = await dio.post('/files', data: formData,
              onSendProgress: (int sent, int total) {
            final progress = sent / total;
            fileUploadProgress[fileUploadProgress.length - 1] = progress;
          });
          ids.add(result.data['data']['id']);
        });
        await dio.patch('/items/employee_course', data: {
          "query": {
            "filter": {
              "employee": {
                "_eq": authController.currentUser.value.employeeData!.id
              },
              "course": {"_eq": courseId}
            }
          },
          "data": {
            "tasks": ids.map((id) => {"directus_files_id": id}).toList(),
          }
        });
        courseController.getCourseByEmployee(
            authController.currentUser.value.employeeData!.id ?? '', courseId);
        loadingUpload.value = false;
        Get.snackbar('Sukses', 'Tugas berhasil diupload',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      loadingUpload.value = false;
      print('errr $e');
    }
  }

  void removeImage(CourseByEmployee data, String id, int? fileId) async {
    loadingUpload.value = true;
    AuthController authController = Get.find<AuthController>();
    CourseController courseController = Get.find<CourseController>();
    print('${id} ${fileId}');

    try {
      await dio.patch('/items/employee_course', data: {
        "query": {
          "filter": {
            "employee": {
              "_eq": authController.currentUser.value.employeeData!.id
            },
            "course": {"_eq": data.course?.id}
          }
        },
        "data": {
          "tasks": {
            "delete": [fileId]
          }
        }
      });
      await dio.delete('/files/$id');
      courseController.getCourseByEmployee(
          authController.currentUser.value.employeeData!.id ?? '',
          data.course?.id ?? '');
      Get.snackbar('Sukses', 'Tugas berhasil dihapus',
          snackPosition: SnackPosition.BOTTOM);
      loadingUpload.value = false;
    } catch (e) {
      loadingUpload.value = false;
      print('errr $e');
    }
  }
}

class TaskAssignment extends StatelessWidget {
  TaskAssignment({super.key});
  String taskDescription = Get.arguments['description'] ?? '';
  String courseId = Get.arguments['courseId'] ?? '';
  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    CourseController courseController = Get.find<CourseController>();

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
                  textAlign: TextAlign.center,
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
                  await taskController.onUploadTask(courseId);
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
              Obx(
                () => taskController.loadingUpload.value
                    ? const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: CircularProgressIndicator(),
                      )
                    : const SizedBox(height: 20),
              ),
              Obx(() => courseController
                      .courseByEmployee.value.data!.first.tasks!.isNotEmpty
                  ? ListView.builder(
                      itemCount: courseController
                          .courseByEmployee.value.data!.first.tasks!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final task = courseController
                            .courseByEmployee.value.data!.first.tasks![index];
                        return ListTile(
                          leading: const Icon(Icons.file_copy,
                              color: primaryColor, size: 30),
                          title: Text(task.directusFilesId!.title!,
                              style: GoogleFonts.mulish(
                                  fontSize: 14,
                                  color: darkText,
                                  fontWeight: FontWeight.w700)),
                          trailing: IconButton(
                              onPressed: () {
                                taskController.removeImage(
                                    courseController
                                        .courseByEmployee.value.data!.first,
                                    task.directusFilesId?.id ?? '',
                                    task.id);
                              },
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red)),
                        );
                      })
                  : Container()),
              // Expanded(
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: RoundedButton(
              //       text: 'Simpan Tugas',
              //       onPressed: () async {
              //         await taskController.(courseId);
              //       },
              //     ),
              //   ),
              // )
            ],
          ),
        ));
  }
}
