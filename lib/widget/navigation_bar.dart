import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void onTabTapped(int index) {
    currentIndex.value = index;
  }
}

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationController navigationController =
        Get.find<NavigationController>();

    return Obx(() => CurvedNavigationBar(
          backgroundColor: const Color.fromRGBO(0, 187, 255, 1),
          color: Colors.white,
          buttonBackgroundColor: const Color.fromRGBO(0, 187, 255, 1),
          height: 65,
          items: [
            SizedBox(
              height: 45,
              child: Column(
                children: [
                  Icon(CupertinoIcons.house_alt,
                      size: 30,
                      color: navigationController.currentIndex.value == 0
                          ? Colors.white
                          : Colors.black),
                  Text(
                    "BERANDA",
                    style: GoogleFonts.mulish(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      color: navigationController.currentIndex.value == 0
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              child: Column(
                children: [
                  Icon(CupertinoIcons.square_list,
                      size: 30,
                      color: navigationController.currentIndex.value == 1
                          ? Colors.white
                          : Colors.black),
                  Text(
                    "KURSUS",
                    style: GoogleFonts.mulish(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      color: navigationController.currentIndex.value == 1
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              child: Column(
                children: [
                  Icon(Icons.emoji_events_outlined,
                      size: 30,
                      color: navigationController.currentIndex.value == 2
                          ? Colors.white
                          : Colors.black),
                  Text("PENCAPAIAN",
                      style: GoogleFonts.mulish(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: navigationController.currentIndex.value == 2
                            ? Colors.white
                            : Colors.black,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              child: Column(
                children: [
                  Icon(CupertinoIcons.book,
                      size: 30,
                      color: navigationController.currentIndex.value == 3
                          ? Colors.white
                          : Colors.black),
                  Text(
                    "KURSUSKU",
                    style: GoogleFonts.mulish(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      color: navigationController.currentIndex.value == 3
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 45,
              child: Column(
                children: [
                  Icon(Icons.person_2_outlined,
                      size: 30,
                      color: navigationController.currentIndex.value == 4
                          ? Colors.white
                          : Colors.black),
                  Text(
                    "AKUN",
                    style: GoogleFonts.mulish(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold,
                      color: navigationController.currentIndex.value == 4
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
          animationDuration: const Duration(milliseconds: 220),
          onTap: (int idx) {
            navigationController.onTabTapped(idx);
          },
          index: navigationController.currentIndex.value,
        ));
  }
}
