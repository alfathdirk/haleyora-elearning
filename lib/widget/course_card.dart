import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final void Function() onTap;
  final String spanText;
  final bool isBookmarked;
  final int duration;
  final int? totalEmployee;
  final void Function()? onTapBookmark;
  final bool? iconBookmark;
  final double? totalDuration;
  final double? heightTitle;

  const CourseCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.onTap,
    this.spanText = "Kursus",
    this.isBookmarked = false,
    this.totalEmployee = 0,
    this.duration = 0,
    this.onTapBookmark,
    this.iconBookmark = true,
    this.totalDuration,
    this.heightTitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomCard(
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
                    loadingBuilder: (context, child, progress) {
                      return progress == null
                          ? child
                          : const Center(
                              child: CircularProgressIndicator(),
                            );
                    },
                    imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100,
                  ),
                ),
              ),
              iconBookmark!
                  ? Positioned(
                      bottom: 0,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isBookmarked ? primaryColor : Colors.white,
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
                          onTap: onTapBookmark,
                          child: Icon(
                            CupertinoIcons.bookmark,
                            color: isBookmarked ? Colors.white : primaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
            ]),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spanText,
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
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
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
                        if (totalEmployee != 0)
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.eye,
                                color: lightGrey,
                                size: 10,
                              ),
                              Text(
                                " $totalEmployee Dipelajari",
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
                              " $duration Menit",
                              style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                                color: lightGrey,
                              ),
                            ),
                          ],
                        ),
                        if (totalDuration != null)
                          SizedBox(
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: totalDuration,
                                minHeight: 6,
                                backgroundColor: Colors.grey[300],
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color.fromARGB(255, 236, 135, 57),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
