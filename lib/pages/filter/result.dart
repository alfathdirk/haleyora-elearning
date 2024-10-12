import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/widget/course_card.dart';

class SearchResultPage extends StatelessWidget {
  SearchResultPage({super.key});
  final query = Get.arguments['query'] ?? '';
  final activityId = Get.arguments['activityId'] ?? '';
  final isFromCategory = Get.arguments['isFromCategory'] ?? false;

  final box = GetStorage();
  CourseController courseController = Get.find<CourseController>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: !isFromCategory
          ? courseController.searchCourse(query)
          : courseController.searchCourseByActivity(activityId),
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
        title: Text("Hasil Pencarian ${query != '' ? '\"$query\"' : ''}",
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
              child: Obx(
                () => courseController.searchResults.length > 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MasonryGridView.count(
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
                                !isFromCategory
                                    ? courseController.searchCourse(query)
                                    : courseController
                                        .searchCourseByActivity(activityId);
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
                        ))
                    : SizedBox(
                        height: Get.height * 0.6,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_off,
                              size: 100,
                              color: greyText,
                            ),
                            Text(
                              "Tidak ada hasil yang ditemukan",
                              style: GoogleFonts.jost(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: darkText),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
