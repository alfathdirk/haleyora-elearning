// create home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/pages/dashboard/achievment_page.dart';
import 'package:haleyora/pages/dashboard/course_page.dart';
import 'package:haleyora/pages/dashboard/home_page.dart';
import 'package:haleyora/pages/dashboard/my_course.dart';
import 'package:haleyora/pages/dashboard/profile.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  NavigationController navigationController = Get.find<NavigationController>();

  @override
  Scaffold build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      CoursePage(),
      AchievmentPage(),
      MyCoursePage(),
      const ProfilePage(),
    ];
    return Scaffold(
      // body
      bottomNavigationBar: const CustomNavigationBar(),
      body: Obx(() => Center(
            child: pages.elementAt(navigationController.currentIndex.value),
          )),
    );
  }
}
