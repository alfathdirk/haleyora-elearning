import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/me.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

class MyCoursePage extends StatelessWidget {
  MyCoursePage({super.key});
  final box = GetStorage();

  Future<void> init() async {
    final courseController = Get.put(CourseController());
    AuthController authController = Get.put(AuthController());
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
    final courseController = Get.put(CourseController());
    AuthController authController = Get.put(AuthController());

    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
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
            height: MediaQuery.of(context).size.height / 1.2,
            padding: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() => MasonryGridView.count(
                    itemCount: courseController.myCourseList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    padding: const EdgeInsets.only(bottom: 12),
                    itemBuilder: (context, index) {
                      OngoingCourseData course =
                          courseController.myCourseList[index];
                      return CourseCard(
                        onTap: () {
                          Get.toNamed("/course-detail/${course.course!.id}");
                        },
                        spanText: course.course?.title ?? "",
                        title: course.course?.title ?? "",
                        description: course.course?.title ?? "",
                        imageUrl:
                            "$imageBaseUrl${course.course?.image}?access_token=${box.read('accessToken')}",
                        totalEmployee: 0,
                        duration: course.course?.duration ?? 0,
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}
