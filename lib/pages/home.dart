// create home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/pages/dashboard/achievment_page.dart';
import 'package:haleyora/pages/dashboard/course_page.dart';
import 'package:haleyora/pages/dashboard/home_page.dart';
import 'package:haleyora/pages/dashboard/my_course.dart';
import 'package:haleyora/pages/dashboard/profile.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final data = Get.arguments;

  NavigationController navigationController = Get.put(NavigationController());

  Future<void> init() async {
    if (data != null) {
      navigationController.currentIndex.value = data;
      navigationController.onTabTapped(data);
    }
  }

// navigationController.onTabTapped(1);
  Scaffold dashboardView(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      CoursePage(),
      AchievmentPage(),
      MyCoursePage(),
      ProfilePage(),
    ];
    return Scaffold(
      // body
      bottomNavigationBar: const CustomNavigationBar(),
      body: Obx(() => Center(
            child: pages.elementAt(navigationController.currentIndex.value),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: init(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return dashboardView(context);
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
