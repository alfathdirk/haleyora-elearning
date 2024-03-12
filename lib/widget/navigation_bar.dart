import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onTabTapped;

  const CustomNavigationBar({required this.onTabTapped, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: Colors.blueGrey,
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      height: 65,
      items: const <Widget>[
        Icon(Icons.home, size: 30, color: Colors.black),
        Icon(Icons.search, size: 30, color: Colors.black),
        Icon(Icons.add, size: 30, color: Colors.black),
        Icon(Icons.favorite, size: 30, color: Colors.black),
        Icon(Icons.person, size: 30, color: Colors.black),
      ],
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
      onTap: onTabTapped,
    );
  }
}
