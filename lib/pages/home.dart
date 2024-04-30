// create home.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/pages/dashboard/achievment_page.dart';
import 'package:haleyora/pages/dashboard/course_page.dart';
import 'package:haleyora/pages/dashboard/home_page.dart';
import 'package:haleyora/pages/dashboard/profile.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> init() async {
    final data = Get.arguments;
    NavigationController navigationController = Get.put(NavigationController());
    if (data != null) {
      navigationController.currentIndex.value = data;
      navigationController.onTabTapped(data);
    }
  }

// navigationController.onTabTapped(1);
  Scaffold dashboardView(BuildContext context) {
    NavigationController navigationController = Get.put(NavigationController());
    final List<Widget> _pages = [
      HomePage(),
      CoursePage(),
      AchievmentPage(),
      CoursePage(),
      ProfilePage(),
    ];
    return Scaffold(
      // body
      bottomNavigationBar: CustomNavigationBar(),
      body: Obx(() => Center(
            child: _pages.elementAt(navigationController.currentIndex.value),
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
