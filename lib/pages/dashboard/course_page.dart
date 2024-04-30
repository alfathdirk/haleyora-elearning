import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/model/model.dart';
import 'package:haleyora/pages/course/model.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

// class CoursePage extends StatefulWidget {
//   final String? title;
//   const CoursePage({Key? key, this.title}) : super(key: key);

//   @override
//   State<CoursePage> createState() => _coursePageState();
// }

class CoursePage extends GetView<CourseController> {
  CoursePage({Key? key}) : super(key: key);
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final courseController = Get.put(CourseController());

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
                  child: RoundedButton(
                    text: "Semua",
                    onPressed: () {
                      // setState(() {
                      //   if (title != "All") {
                      //     title = "All";
                      //   }
                      // });
                    },
                    // color: title == 'All' ? primaryColor : Colors.white,
                    // textColor: title == 'All' ? Colors.white : primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RoundedButton(
                    text: "Ditandai",
                    onPressed: () {
                      // setState(() {
                      //   if (title != "Ditandai") {
                      //     title = "Ditandai";
                      //   }
                      // });
                    },
                    // color: title != 'All' ? primaryColor : Colors.white,
                    // textColor: title != 'All' ? Colors.white : primaryColor,
                  ),
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
                      // course.image?.id + '/' + course.image?.filenameDisk ??
                      //     '' + '.png';
                      return CourseCard(
                        onTap: () {
                          Get.toNamed("/course-detail/${course.id}");
                        },
                        spanText: course.activities?.title ?? "",
                        title: course.title ?? "",
                        description: course.activities?.title ?? "",
                        imageUrl:
                            "${imageBaseUrl}${imgId}?access_token=${box.read('accessToken')}",
                        totalEmployee: course.employeeCourse?.length ?? 0,
                        // TODO: check if course is bookmarked
                        isBookmarked: true,
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
