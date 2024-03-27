// create home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/pages/dashboard/achievment_page.dart';
import 'package:haleyora/pages/dashboard/course_page.dart';
import 'package:haleyora/pages/dashboard/home_page.dart';
import 'package:haleyora/pages/dashboard/profile.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    return Scaffold(
        // body
        bottomNavigationBar: CustomNavigationBar(),
        body: PageView(
          controller: navigationController.pageController,
          children: [
            HomePage(),
            CoursePage(),
            AchievmentPage(),
            CoursePage(title: "Pinned"),
            ProfilePage(),
          ],
        ));
  }
}
