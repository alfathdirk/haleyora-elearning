import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';

class CourseDetail extends StatelessWidget {
  const CourseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 300,
                      child: Stack(
                        children: [
                          Image.network(
                            'https://picsum.photos/450?image=9',
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Positioned(
                            left: 0,
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back),
                              color: Colors.white,
                            ),
                          ),
                          Positioned(
                            top: 200,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(28.0),
                              child: CustomCard(
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Yantek | Operasi Sistem',
                                        style: GoogleFonts.mulish(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: orangeText,
                                            decoration: TextDecoration.none),
                                      ),
                                      Text(
                                        'Penanganan gangguan kabel incoming (Trafo - PHB TR )/outgoing TR',
                                        style: GoogleFonts.mulish(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                            decoration: TextDecoration.none),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: greyText,
                                                size: 10,
                                              ),
                                              Text(
                                                '4.5',
                                                style: GoogleFonts.mulish(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: greyText,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                color: greyText,
                                                size: 10,
                                              ),
                                              Text(
                                                '2h 30m',
                                                style: GoogleFonts.mulish(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: greyText,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        height: 2,
                                        color: Colors.grey[100],
                                      ),
                                      const SizedBox(height: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Deskripsi',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus.',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3.5),
                shrinkWrap: true,
                children: [
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 119, 119, 119)
                              .withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/video-player");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.picture_as_pdf_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Baca Materi',
                            style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 119, 119, 119)
                              .withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/video-player");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.play_circle_outlined,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Tonton Video',
                            style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 119, 119, 119)
                              .withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/video-player");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.pencil_ellipsis_rectangle,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Mulai Ujian',
                            style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 119, 119, 119)
                              .withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed("/video-player");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            CupertinoIcons.news,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Tugas',
                            style: GoogleFonts.mulish(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
