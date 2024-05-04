import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/course_card.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/widget/popup.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    // QuizController quizController = Get.put(QuizController());
    AuthController authController = Get.put(AuthController());
    CourseController courseController = Get.put(CourseController());

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Obx(() => Text(courseController.categoryList.length.toString())),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage("assets/images/distribusi.png"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Selamat datang",
                                  style: GoogleFonts.mulish(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: darkText),
                                ),
                                Obx(() => Text(
                                      authController.currentUser.value
                                              .employeeData?.fullName ??
                                          '',
                                      style: GoogleFonts.mulish(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: darkText),
                                    )),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize: 24,
                          icon: const Icon(Icons.notifications_active_outlined),
                          onPressed: () async {
                            // await showDialog(
                            //     context: context,
                            //     builder: (_) => ImageDialog(
                            //           buttonText: "OK",
                            //           onPressed: () {
                            //             Get.back();
                            //           },
                            //           image: "assets/images/distribusi.png",
                            //           title: "Anda mempunyai 1 notifikasi baru",
                            //         ));
                            Get.dialog(ImageDialog(
                                buttonText: "OK",
                                onPressed: () {
                                  Get.back();
                                },
                                image: "assets/images/distribusi.png",
                                title: "Anda mempunyai 1 notifikasi baru"));
                            // Get.toNamed("/notification");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Text(
                    "Apa yang mau kamu pelajari hari ini ?\nSilahkan masukan kata kunci nya dibawah ini ya",
                    style: GoogleFonts.mulish(fontSize: 10, color: darkText),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              radius: 100,
              width: MediaQuery.of(context).size.width / 1.09,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: greyText,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari Kursus",
                          border: InputBorder.none,
                          hintStyle:
                              GoogleFonts.mulish(fontSize: 12, color: greyText),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/filter");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColor,
                        ),
                        child: const Icon(
                          CupertinoIcons.square_list,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     if (quizController.isStart.value == false) {
            //       quizController.startQuiz();
            //     }
            //     Get.toNamed("/quiz");
            //   },
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     padding: const EdgeInsets.all(20),
            //     child: CustomCard(
            //       color: primaryColor,
            //       child: Stack(
            //         children: [
            //           Positioned(
            //               right: 0,
            //               bottom: 0,
            //               child: Icon(
            //                 CupertinoIcons.pencil_ellipsis_rectangle,
            //                 color: Colors.white.withOpacity(0.1),
            //                 size: 100,
            //               )),
            //           Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                     padding: const EdgeInsets.only(
            //                       left: 20,
            //                       right: 20,
            //                       top: 20,
            //                       bottom: 10,
            //                     ),
            //                     width: MediaQuery.of(context).size.width - 150,
            //                     child: Text(
            //                       "Anda mempunyai Ujian tertunda, segera selesaikan ujian Anda",
            //                       style: GoogleFonts.mulish(
            //                         color: Colors.white,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 14,
            //                       ),
            //                     ),
            //                   ),
            //                   Container(
            //                     padding: const EdgeInsets.only(
            //                       left: 20,
            //                       right: 20,
            //                       bottom: 20,
            //                     ),
            //                     width: MediaQuery.of(context).size.width - 150,
            //                     child: Text(
            //                       "Selamat, Selesaikan pencapaianmu sekarang.",
            //                       style: GoogleFonts.mulish(
            //                         color: greyText,
            //                         fontWeight: FontWeight.normal,
            //                         fontSize: 10,
            //                       ),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //               Container(
            //                 padding: const EdgeInsets.only(
            //                   right: 20,
            //                 ),
            //                 child: Obx(() => Text(
            //                       "${(quizController.start.toInt() / 60).floor()}:${(quizController.start % 60).toString().padLeft(2, '0')}",
            //                       style: GoogleFonts.mulish(
            //                         color: Colors.yellow,
            //                         fontWeight: FontWeight.bold,
            //                         fontSize: 30,
            //                       ),
            //                     )),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bidang Pekerjaan",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkText),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Obx(() => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: courseController.categoryList.length,
                    itemBuilder: (context, index) {
                      CategoryData categoryList =
                          courseController.categoryList[index];

                      return CustomCard(
                          child: InkWell(
                        onTap: () {
                          // Get.toNamed("/category-list/${sectors[i].title}");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              loadingBuilder: (context, child, progress) {
                                return progress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      );
                              },
                              '$imageBaseUrl${categoryList.image}?access_token=${box.read('accessToken')}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              categoryList.name ?? "",
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: darkText),
                            ),
                          ],
                        ),
                      ));
                    },
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rekomendasi Pembelajaran",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkText),
                  ),
                  Text(
                    "Lihat Semua",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Obx(() => !courseController.loading.value &&
                        courseController.courseList.isNotEmpty
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: courseController.courseList.length < 5
                            ? courseController.courseList.length
                            : 5,
                        itemBuilder: (context, index) {
                          CourseData course =
                              courseController.courseList[index];
                          var imgId = course.image?.id;
                          bool isBookmarked = course.employeeBookmark!
                              .map((e) => e.employee)
                              .contains(authController
                                  .currentUser.value.employeeData!.id);
                          return Container(
                            width: 300,
                            padding: const EdgeInsets.only(
                              left: 20,
                              bottom: 20,
                            ),
                            child: CourseCard(
                              onTapBookmark: () async {
                                if (!isBookmarked) {
                                  await courseController.bookmarkCourse(
                                      course.id.toString(),
                                      authController
                                          .currentUser.value.employeeData!.id
                                          .toString());
                                } else {
                                  await courseController.unBookmarkCourse(
                                      course.id.toString(),
                                      authController
                                          .currentUser.value.employeeData!.id
                                          .toString());
                                }
                                // unbookmark
                                if (courseController.isAllCourse.isTrue) {
                                  courseController.fetchAllCourses();
                                } else {
                                  courseController.getBookmarkByEmployee(
                                      authController
                                          .currentUser.value.employeeData!.id
                                          .toString());
                                }
                              },
                              onTap: () {
                                Get.toNamed("/course-detail");
                              },
                              title: course.title ?? "sdf",
                              imageUrl:
                                  '$imageBaseUrl${course.image!.filenameDisk}?access_token=${box.read('accessToken')}',
                              description: "Kursus ini akan membantu anda",
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()))),
          ],
        ),
      ),
    );
  }
}

class Sectors {
  final String title;
  final String imageUrl;
  final String url;

  Sectors({required this.title, required this.imageUrl, this.url = ""});
}
