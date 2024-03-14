import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/course_card.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: RoundedButton(
                  text: "Semua",
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: RoundedButton(
                  text: "Ditandai",
                  onPressed: () {},
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
                  title:
                      "Belajar Flutter $index with long description here and there and everywhere $index here long text",
                  description:
                      "Belajar Flutter $index with long description here and there and everywhere",
                  imageUrl: "https://picsum.photos/200/300",
                );
              },
            ),
          ),
        ),
      ],
    ));
  }
}
