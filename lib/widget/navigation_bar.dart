import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';

class CustomNavigationBar extends StatelessWidget {
  final Function(int) onTabTapped;

  const CustomNavigationBar({required this.onTabTapped, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      backgroundColor: primaryColor,
      color: Colors.white,
      buttonBackgroundColor: primaryColor,
      height: 65,
      items: [
        SizedBox(
          height: 45,
          child: Column(
            children: [
              const Icon(CupertinoIcons.house_alt, size: 30, color: Colors.black),
              Text(
                "BERANDA",
                style: GoogleFonts.mulish(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 45,
          child: Column(
            children: [
              const Icon(CupertinoIcons.square_list, size: 30, color: Colors.black),
              Text(
                "KURSUS",
                style: GoogleFonts.mulish(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 45,
          child: Column(
            children: [
              const Icon(Icons.emoji_events_outlined, size: 30, color: Colors.black),
              Text("PENCAPAIAN",
                  style: GoogleFonts.mulish(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 45,
          child: Column(
            children: [
              const Icon(CupertinoIcons.book, size: 30, color: Colors.black),
              Text(
                "KURSUSKU",
                style: GoogleFonts.mulish(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 45,
          child: Column(
            children: [
              const Icon(Icons.person_2_outlined, size: 30, color: Colors.black),
              Text(
                "AKUN",
                style: GoogleFonts.mulish(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
      onTap: onTabTapped,
    );
  }
}
