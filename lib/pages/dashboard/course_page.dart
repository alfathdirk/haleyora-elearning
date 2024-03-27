import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/course_card.dart';

class CoursePage extends StatefulWidget {
  final String? title;
  const CoursePage({Key? key, this.title}) : super(key: key);

  @override
  State<CoursePage> createState() => _coursePageState();
}

class _coursePageState extends State<CoursePage> {
  String title = "All";

  @override
  void initState() {
    super.initState();
    title = widget.title ?? "All";
  }

  @override
  Widget build(BuildContext context) {
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
                      setState(() {
                        if (title != "All") {
                          title = "All";
                        }
                      });
                    },
                    color: title == 'All' ? primaryColor : Colors.white,
                    textColor: title == 'All' ? Colors.white : primaryColor,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: RoundedButton(
                    text: "Ditandai",
                    onPressed: () {
                      setState(() {
                        if (title != "Ditandai") {
                          title = "Ditandai";
                        }
                      });
                    },
                    color: title != 'All' ? primaryColor : Colors.white,
                    textColor: title != 'All' ? Colors.white : primaryColor,
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
              child: MasonryGridView.count(
                itemCount: 20,
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                padding: const EdgeInsets.only(bottom: 12),
                itemBuilder: (context, index) {
                  return CourseCard(
                    onTap: () {
                      Get.toNamed("/course-detail");
                    },
                    title:
                        "Belajar Flutter $index with long description here and there and everywhere $index here long text",
                    description:
                        "Belajar Flutter $index with long description here and there and everywhere",
                    imageUrl: "https://picsum.photos/200/300?random=$index",
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
