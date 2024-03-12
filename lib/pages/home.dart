// create home.dart
import 'package:flutter/material.dart';
import 'package:haleyora/pages/dashboard/home_page.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body
        bottomNavigationBar: CustomNavigationBar(
          onTabTapped: (index) {
            _pageController.jumpToPage(index);
          },
        ),
        body: PageView(
          controller: _pageController,
          children: const <Widget>[
            HomePage(),
            Center(
              child: Text("Search"),
            ),
            Center(
              child: Text("Add"),
            ),
            Center(
              child: Text("Favorite"),
            ),
            Center(
              child: Text("Profile"),
            ),
          ],
        ));
  }
}