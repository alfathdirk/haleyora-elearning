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

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});
  final query = Get.parameters['query'];
  final box = GetStorage();

  CourseController courseController = Get.find<CourseController>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: courseController.searchCourse(query!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return buildWidget(context);
        }
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Hasil Pencarian \"$query\"",
            style: GoogleFonts.jost(
                fontSize: 20, fontWeight: FontWeight.bold, color: darkText)),
        centerTitle: false,
        titleSpacing: 20,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.2,
              padding: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx(() => MasonryGridView.count(
                      itemCount: courseController.searchResults.length,
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      padding: const EdgeInsets.only(bottom: 12),
                      itemBuilder: (context, index) {
                        CourseData course =
                            courseController.searchResults[index];
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
      ),
    ));
  }
}
