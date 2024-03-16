import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Stack(children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              height: 150,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 100,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 12,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {},
                  child: const Icon(
                    CupertinoIcons.bookmark,
                    color: primaryColor,
                    size: 16,
                  ),
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.mulish(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: orangeText,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: GoogleFonts.mulish(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.eye,
                            color: lightGrey,
                            size: 10,
                          ),
                          Text(
                            " 182 dipelajari",
                            style: GoogleFonts.mulish(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: lightGrey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.time,
                            color: lightGrey,
                            size: 10,
                          ),
                          Text(
                            " 130 Menit",
                            style: GoogleFonts.mulish(
                              fontSize: 10,
                              fontWeight: FontWeight.normal,
                              color: lightGrey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
