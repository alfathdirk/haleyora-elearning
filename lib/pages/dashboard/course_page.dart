import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

class CoursePage extends StatelessWidget {
  CoursePage({super.key});
  final box = GetStorage();

  CourseController courseController = Get.find<CourseController>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Kursus",
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
                            await courseController
                                .getBookmarkByEmployee(box.read('employee_id'));
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
              height: MediaQuery.of(context).size.height * 0.78,
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                            .contains(box.read('employee_id'));
                        return CourseCard(
                          onTapBookmark: () async {
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
                            if (courseController.isAllCourse.isTrue) {
                              courseController.fetchAllCourses();
                            } else {
                              courseController.getBookmarkByEmployee(
                                  box.read('employee_id'));
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
      ),
    ));
  }
}
