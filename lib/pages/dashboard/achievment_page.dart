import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/chart.dart';

class AchievmentPage extends StatelessWidget {
  AchievmentPage({super.key});
  CourseController courseController = Get.find<CourseController>();
  QuizController quizController = Get.find<QuizController>();

  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          courseController.getCourseByEmployee(box.read('employee_id'), null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return buildWidget(context);
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pencapaian",
            style: GoogleFonts.jost(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          centerTitle: false,
          titleSpacing: 20,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomCard(
                            height: 150,
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.emoji_events_outlined,
                                      color: Colors.grey[100],
                                      size: 100,
                                    )),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    if (courseController.courseByEmployee.value
                                        .data!.isNotEmpty)
                                      ProgressPieChart(
                                        examScores: 100,
                                        employeeScore: courseController
                                                    .courseByEmployee
                                                    .value
                                                    .data !=
                                                null
                                            ? (courseController.courseByEmployee
                                                    .value.data!
                                                    .map((e) => e.examScore)
                                                    .reduce((value, element) =>
                                                        value! + element!)!
                                                    .toDouble() /
                                                courseController
                                                    .courseByEmployee
                                                    .value
                                                    .data!
                                                    .length)
                                            : 0,
                                      ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Total Kursus",
                                            style: GoogleFonts.mulish(
                                              color: greyText,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "${courseController.courseByEmployee.value.data!.length}",
                                            style: GoogleFonts.mulish(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24,
                                            ),
                                          ),
                                          SizedBox(
                                            // overflow: TextOverflow.ellipsis,
                                            child: Text(
                                              // overflow: TextOverflow.ellipsis,
                                              "Selamat, Selesaikan pencapaianmu sekarang.",
                                              style: GoogleFonts.mulish(
                                                color: greyText,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                                // text over flow
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
                  courseController.courseByEmployee.value.data!.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Kursus yang sedang diikuti",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.jost(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.bookmark_add_outlined,
                                size: 100,
                                color: greyText,
                              ),
                              Text(
                                "Belum ada kursus yang diikuti",
                                style: GoogleFonts.jost(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: darkText),
                              ),
                            ],
                          ),
                        ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          courseController.courseByEmployee.value.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(
                              bottom: 12, left: 16, right: 16),
                          child: CustomCard(
                            height: 90,
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.orange[50],
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events_outlined,
                                    color: Colors.orange,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 13,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${courseController.courseByEmployee.value.data![index].course!.activities?.title}",
                                        style: GoogleFonts.mulish(
                                          color: orangeText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        child: Text(
                                          "${courseController.courseByEmployee.value.data![index].course!.title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: GoogleFonts.mulish(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, top: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Nilai Test:",
                                              style: GoogleFonts.mulish(
                                                color: greyText,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              " ${courseController.courseByEmployee.value.data![index].examScore}",
                                              style: GoogleFonts.mulish(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            !((courseController
                                                            .courseByEmployee
                                                            .value
                                                            .data!
                                                            .isNotEmpty &&
                                                        courseController
                                                                .courseByEmployee
                                                                .value
                                                                .data![index]
                                                                .examAttempt! >
                                                            0 &&
                                                        !quizController
                                                            .hasOngoingQuiz
                                                            .value) ||
                                                    (quizController
                                                            .ongoingCourseId
                                                            .value ==
                                                        courseController
                                                            .courseByEmployee
                                                            .value
                                                            .data![index]
                                                            .course!
                                                            .id))
                                                ? const SizedBox()
                                                : InkWell(
                                                    onTap: () {
                                                      final c = courseController
                                                          .courseByEmployee
                                                          .value
                                                          .data![index];
                                                      Get.toNamed(
                                                          '/quiz/${c.course!.examQuiz}/${c.course!.id}');
                                                      quizController
                                                              .ongoingCourseId
                                                              .value =
                                                          c.course!.id!;
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "ULANGI TEST",
                                                          style: GoogleFonts
                                                              .mulish(
                                                            color: primaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10,
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: primaryColor,
                                                          size: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.toNamed('/certificate',
                                                    parameters: {
                                                      'courseId':
                                                          '${courseController.courseByEmployee.value.data![index].id}',
                                                    });
                                              },
                                              child: Row(
                                                children: [
                                                  courseController
                                                              .courseByEmployee
                                                              .value
                                                              .data![index]
                                                              .examScore! >
                                                          courseController
                                                              .courseByEmployee
                                                              .value
                                                              .data![index]
                                                              .course!
                                                              .minScore!
                                                      ? Row(
                                                          children: [
                                                            Text(
                                                              "LIHAT SERTIFIKAT",
                                                              style: GoogleFonts
                                                                  .mulish(
                                                                color:
                                                                    primaryColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 9,
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color:
                                                                  primaryColor,
                                                              size: 9,
                                                            )
                                                          ],
                                                        )
                                                      : const SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
