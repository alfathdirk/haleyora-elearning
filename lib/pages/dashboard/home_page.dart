import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/controller/search.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/course_card.dart';
import 'package:haleyora/controller/quiz.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final box = GetStorage();
  AuthController authController = Get.find<AuthController>();
  CourseController courseController = Get.find<CourseController>();
  QuizController quizController = Get.find<QuizController>();
  CustomSearchController searchController = Get.put(CustomSearchController());

  Future<void> init() async {
    if (authController.currentUser.value.employeeData == null) {
      await authController.getMe();
    }
    log(box.read('accessToken'));
    await courseController.getCategory();
    await courseController.getCourseRecommendation(box.read('employee_id'));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Obx(() => buildWidget(context));
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: RefreshIndicator(
        onRefresh: () async {
          log('message');
          await courseController.fetchAllCourses();
          await courseController
              .getCourseRecommendation(box.read('employee_id'));
        },
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(authController
                                            .currentUser
                                            .value
                                            .employeeData!
                                            .photo ??
                                        'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png'),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Selamat datang",
                                        style: GoogleFonts.mulish(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                            color: darkText),
                                      ),
                                      Text(
                                        authController.currentUser.value
                                                .employeeData?.fullName ??
                                            "",
                                        style: GoogleFonts.mulish(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                            color: darkText),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          iconSize: 24.sp,
                          icon: const Icon(Icons.notifications_active_outlined),
                          onPressed: () async {
                            Get.toNamed("/notification");
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 0),
                        child: Text(
                          "Apa yang mau kamu pelajari hari ini ?\nSilahkan masukan kata kunci nya dibawah ini ya",
                          style: GoogleFonts.mulish(
                              fontSize: 10.sp, color: darkText),
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
                              controller: searchController.searchController,
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  Get.toNamed("/search-result", arguments: {
                                    'query': value,
                                  });
                                  return;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "Cari Kursus",
                                border: InputBorder.none,
                                hintStyle: GoogleFonts.mulish(
                                    fontSize: 12.sp, color: greyText),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/filter");
                            },
                            child: Stack(
                              children: [
                                Container(
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
                                if (courseController.listFilter.isNotEmpty)
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.orangeAccent,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  if (quizController.hasOngoingQuiz.isTrue)
                    Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                '/quiz/${quizController.ongoingQuizId.value}/${quizController.ongoingCourseId.value}');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            child: CustomCard(
                              color: primaryColor,
                              child: Stack(
                                children: [
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Icon(
                                        CupertinoIcons
                                            .pencil_ellipsis_rectangle,
                                        color: Colors.white.withOpacity(0.1),
                                        size: 100,
                                      )),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              top: 20,
                                              bottom: 10,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            child: Text(
                                              "Anda mempunyai Ujian tertunda, segera selesaikan ujian Anda",
                                              style: GoogleFonts.mulish(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 20,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                150,
                                            child: Text(
                                              "Selesaikan ujianmu sekarang!",
                                              style: GoogleFonts.mulish(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10.sp,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                          right: 20,
                                        ),
                                        child: Obx(() => Text(
                                              "${(quizController.startDuration / 60).floor().toString().padLeft(2, '0')}:${(quizController.startDuration % 60).floor().toString().padLeft(2, '0')}",
                                              style: GoogleFonts.mulish(
                                                color: Colors.yellow,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30.sp,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Bidang Pekerjaan",
                          style: GoogleFonts.mulish(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: darkText),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 20,
                        childAspectRatio: 1,
                        mainAxisSpacing: 15,
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
                            Get.toNamed("/category-list/${categoryList.id}");
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
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: darkText),
                              ),
                            ],
                          ),
                        ));
                      },
                    ),
                  ),
                  courseController.courseRecommendation.isEmpty
                      ? const SizedBox()
                      : Container(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rekomendasi Pembelajaran",
                                style: GoogleFonts.mulish(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                    color: darkText),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed("/course-recommendation");
                                },
                                child: Text(
                                  "Lihat Semua",
                                  style: GoogleFonts.mulish(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                  Container(
                    child: courseController.courseRecommendation.isNotEmpty
                        ? SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: courseController
                                          .courseRecommendation.length <
                                      5
                                  ? courseController.courseRecommendation.length
                                  : 5,
                              itemBuilder: (context, index) {
                                CourseData course = courseController
                                    .courseRecommendation[index];
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  padding: EdgeInsets.only(
                                    left: 20,
                                    bottom: 20,
                                    right: index ==
                                            courseController
                                                    .courseRecommendation
                                                    .length -
                                                1
                                        ? 20
                                        : 0,
                                  ),
                                  child: CourseCard(
                                    onTapBookmark: () async {
                                      bool isBookmarked = course
                                          .employeeBookmark!
                                          .map((e) => e.employee)
                                          .contains(box.read('employee_id'));
                                      if (!isBookmarked) {
                                        await courseController.bookmarkCourse(
                                            course.id.toString(),
                                            box.read('employee_id'));
                                      } else {
                                        await courseController.unBookmarkCourse(
                                            course.id.toString(),
                                            box.read('employee_id'));
                                      }
                                      // unbookmark
                                      await courseController
                                          .getCourseRecommendation(
                                              box.read('employee_id'));
                                    },
                                    onTap: () {
                                      Get.toNamed(
                                          "/course-detail/${course.id}");
                                    },
                                    spanText: course.activities?.title ?? "",
                                    isBookmarked: course.employeeBookmark!
                                        .map((e) => e.employee)
                                        .contains(box.read('employee_id')),
                                    title: course.title ?? "",
                                    totalEmployee:
                                        course.employeeCourse?.length ?? 0,
                                    duration: course.duration ?? 0,
                                    imageUrl:
                                        '$imageBaseUrl${course.image!.filenameDisk}?access_token=${box.read('accessToken')}',
                                    description:
                                        "Kursus ini akan membantu anda",
                                  ),
                                );
                              },
                            ))
                        : courseController.loading.value == true
                            ? const Center(child: CircularProgressIndicator())
                            : Container(
                                padding: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text(
                                      "Belum ada rekomendasi pembelajaran"),
                                ),
                              ),
                  ),
                ],
              )
            ],
          ),
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
