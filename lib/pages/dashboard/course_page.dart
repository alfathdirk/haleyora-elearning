import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

class CoursePage extends GetView<CourseController> {
  CoursePage({super.key});
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
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
                    text: "Semua",
                    onPressed: () {
                      courseController.fetchAllCourses();
                    },
                    color: courseController.isAllCourse.isTrue
                        ? primaryColor
                        : Colors.white,
                    textColor: courseController.isAllCourse.isTrue
                        ? Colors.white
                        : primaryColor,
                  ),
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Obx(() => RoundedButton(
                        text: "Ditandai",
                        onPressed: () async {
                          await courseController.getBookmarkByEmployee(
                              authController.currentUser.value.employeeData!.id
                                  .toString());
                        },
                        color: courseController.isAllCourse.isTrue
                            ? Colors.white
                            : primaryColor,
                        textColor: courseController.isAllCourse.isTrue
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
                    itemCount: courseController.courseList.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    padding: const EdgeInsets.only(bottom: 12),
                    itemBuilder: (context, index) {
                      CourseData course = courseController.courseList[index];
                      var imgId = course.image?.id;
                      bool isBookmarked = course.employeeBookmark!
                          .map((e) => e.employee)
                          .contains(authController
                              .currentUser.value.employeeData!.id);
                      return CourseCard(
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
                          Get.toNamed("/course-detail/${course.id}");
                        },
                        spanText: course.activities?.title ?? "",
                        title: course.title ?? "",
                        description: course.activities?.title ?? "",
                        imageUrl:
                            "$imageBaseUrl$imgId?access_token=${box.read('accessToken')}",
                        totalEmployee: course.employeeCourse?.length ?? 0,
                        isBookmarked: isBookmarked,
                        duration: course.duration ?? 0,
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
