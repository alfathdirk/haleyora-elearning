import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';

import 'package:url_launcher/url_launcher.dart';

class CourseDetail extends StatelessWidget {
  CourseDetail({super.key});
  final id = Get.parameters['id'];
  final courseController = Get.put(CourseController());
  final AuthController authController = Get.put(AuthController());
  final box = GetStorage();

  Future<void> _launchInBrowserView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: courseController.fetchCourseById(id!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => buildScafold(context));
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildScafold(BuildContext context) {
    CourseData course = courseController.courseDetail.value;
    courseController.checkCourseIsTaken(
        id!, authController.currentUser.value.employeeData!.id.toString());

    courseController.isCourseCompleted(
        id!, authController.currentUser.value.employeeData!.id.toString());

    final isTaken = courseController.isTaken.value;
    final isCompleted = courseController.isCompleted.value;

    return SafeArea(
      child: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: Stack(
                        children: [
                          Image.network(
                            loadingBuilder: (context, child, progress) {
                              return progress == null &&
                                      course.image?.id != null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                            "$imageBaseUrl${course.image?.id}?access_token=${box.read('accessToken')}",
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Positioned(
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            top: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: CustomCard(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        course.activities?.title ?? '',
                                        style: GoogleFonts.mulish(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: orangeText,
                                            decoration: TextDecoration.none),
                                      ),
                                      Text(
                                        course.title ?? '',
                                        style: GoogleFonts.mulish(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            decoration: TextDecoration.none),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: greyText,
                                                size: 12,
                                              ),
                                              Text(
                                                '${course.employeeCourse?.length.toString() ?? '0'} Dipelajari',
                                                style: GoogleFonts.mulish(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: greyText,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                color: greyText,
                                                size: 10,
                                              ),
                                              Text(
                                                '${course.duration.toString() ?? '0'} Menit',
                                                style: GoogleFonts.mulish(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: greyText,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 2,
                                        color: Colors.grey[100],
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Deskripsi',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            course.description ?? '',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          !isTaken && !isCompleted
                                              ? Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  child: RoundedButton(
                                                    text: 'Ikuti Kursus',
                                                    onPressed: () async {
                                                      await courseController
                                                          .takeCourse(
                                                              course.id
                                                                  .toString(),
                                                              authController
                                                                  .currentUser
                                                                  .value
                                                                  .employeeData!
                                                                  .id
                                                                  .toString());
                                                    },
                                                    color: primaryColor,
                                                    textColor: Colors.white,
                                                  ),
                                                )
                                              : const SizedBox(),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            isTaken && !isCompleted
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3.5),
                      shrinkWrap: true,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // print(
                            //     '${imageBaseUrl}/${course.materialContent}?access_token=${box.read('accessToken')}');
                            final Uri url = Uri.parse(
                                '$imageBaseUrl${course.materialContent}?access_token=${box.read('accessToken')}');
                            _launchInBrowserView(url);
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119)
                                          .withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.picture_as_pdf_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Baca Materi',
                                  style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/video-player/${course.videoContent}');
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119)
                                          .withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.play_circle_outlined,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Tonton Video',
                                  style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (courseController.isCompleted.value) {
                              return;
                            }
                            Get.toNamed('/quiz/${course.examQuiz}/$id');
                          },
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              // opacity: 0.3
                              color: course.isOpenExam! &&
                                      !courseController.isCompleted.value
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119)
                                          .withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.pencil_ellipsis_rectangle,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Mulai Ujian',
                                  style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.toNamed('/task-detail/${course.id}',
                              arguments: {
                                'description': course.taskDescription ?? '',
                              }),
                          child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119)
                                          .withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  CupertinoIcons.news,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  'Tugas',
                                  style: GoogleFonts.mulish(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      decoration: TextDecoration.none),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
