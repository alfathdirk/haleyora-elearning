import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/me.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

class MyCoursePage extends StatelessWidget {
  MyCoursePage({super.key});
  final box = GetStorage();

  CourseController courseController = Get.find<CourseController>();
  AuthController authController = Get.find<AuthController>();

  Future<void> init() async {
    courseController.setMyCourseList(
        authController.currentUser.value.completedCourses!.toList(), false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildWidget(context);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Kursusku",
            style: GoogleFonts.jost(
                fontSize: 20, fontWeight: FontWeight.bold, color: darkText)),
        centerTitle: false,
        titleSpacing: 20,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: Obx(
                    () => RoundedButton(
                      text: "Selesai",
                      onPressed: () async {
                        await authController.getMe();
                        courseController.setMyCourseList(
                            authController.currentUser.value.completedCourses!
                                .toList(),
                            false);
                      },
                      color: courseController.tabOngoing.isFalse
                          ? primaryColor
                          : Colors.white,
                      textColor: courseController.tabOngoing.isFalse
                          ? Colors.white
                          : primaryColor,
                    ),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Obx(() => RoundedButton(
                          text: "Berjalan",
                          onPressed: () async {
                            await authController.getMe();
                            courseController.setMyCourseList(
                                authController.currentUser.value.ongoingCourses!
                                    .toList(),
                                true);
                          },
                          color: courseController.tabOngoing.isFalse
                              ? Colors.white
                              : primaryColor,
                          textColor: courseController.tabOngoing.isFalse
                              ? primaryColor
                              : Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 20),
              child: Obx(() => courseController.myCourseList.length > 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MasonryGridView.count(
                        itemCount: courseController.myCourseList.length,
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        padding: const EdgeInsets.only(bottom: 12),
                        itemBuilder: (context, index) {
                          OngoingCourseData course =
                              courseController.myCourseList[index];
                          return CourseCard(
                            onTap: () {
                              Get.toNamed(
                                  "/course-detail/${course.course!.id}");
                            },
                            spanText: course.course?.activities ?? '',
                            title: course.course?.title ?? "",
                            description: course.course?.title ?? "",
                            imageUrl:
                                "$imageBaseUrl${course.course?.image}?access_token=${box.read('accessToken')}",
                            duration: course.course?.duration ?? 0,
                            iconBookmark: false,
                            totalDuration: course.lastVideoDuration != null
                                ? course.lastVideoDuration! /
                                    course.videoDuration!.toDouble()
                                : 0,
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: Get.height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.book_circle,
                            size: 100,
                            color: greyText,
                          ), //
                          Text(
                            "Belum ada kursus yang diambil",
                            style: GoogleFonts.jost(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: darkText),
                          ),
                        ],
                      ),
                    )),
            ),
          ],
        ),
      ),
    ));
  }
}
