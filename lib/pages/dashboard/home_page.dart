import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/course_card.dart';
import 'package:haleyora/pages/quiz/controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Sectors> sectors = [
    Sectors(
        title: "Distribusi",
        imageUrl: "/images/distribusi.png",
        url: '/category-list/distribusi'),
    Sectors(
        title: "Transmisi",
        imageUrl: "/images/transmisi.png",
        url: '/category-list/transmisi'),
    Sectors(
        title: "Pembangkit",
        imageUrl: "/images/pembangkit.png",
        url: '/category-list/pembangkit'),
  ];

  @override
  Widget build(BuildContext context) {
    QuizController quizController = Get.put(QuizController());

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width - 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage("https://picsum.photos/200/300"),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Selamat datang",
                                  style: GoogleFonts.mulish(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: darkText),
                                ),
                                Text(
                                  "John Doe",
                                  style: GoogleFonts.mulish(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: darkText),
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                          iconSize: 24,
                          icon: const Icon(Icons.notifications_active_outlined),
                          onPressed: () {
                            Get.toNamed("/notification");
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 0),
                  child: Text(
                    "Apa yang mau kamu pelajari hari ini ?\nSilahkan masukan kata kunci nya dibawah ini ya",
                    style: GoogleFonts.mulish(fontSize: 10, color: darkText),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomCard(
              radius: 100,
              width: MediaQuery.of(context).size.width / 1.09,
              child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: greyText,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Cari Kursus",
                          border: InputBorder.none,
                          hintStyle:
                              GoogleFonts.mulish(fontSize: 12, color: greyText),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/filter");
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: primaryColor,
                        ),
                        child: Icon(
                          CupertinoIcons.square_list,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (quizController.isStart.value == false) {
                  quizController.startQuiz();
                }
                Get.toNamed("/quiz");
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                child: CustomCard(
                  color: primaryColor,
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            CupertinoIcons.pencil_ellipsis_rectangle,
                            color: Colors.white.withOpacity(0.1),
                            size: 100,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 20,
                                  bottom: 10,
                                ),
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  "Anda mempunyai Ujian tertunda, segera selesaikan ujian Anda",
                                  style: GoogleFonts.mulish(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                width: MediaQuery.of(context).size.width - 150,
                                child: Text(
                                  "Selamat, Selesaikan pencapaianmu sekarang.",
                                  style: GoogleFonts.mulish(
                                    color: greyText,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              right: 20,
                            ),
                            child: Obx(() => Text(
                                  "${(quizController.start.toInt() / 60).floor()}:${(quizController.start % 60).toString().padLeft(2, '0')}",
                                  style: GoogleFonts.mulish(
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Bidang Pekerjaan",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkText),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                children: [
                  for (var i = 0; i < sectors.length; i++)
                    CustomCard(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("/category-list/${sectors[i].title}");
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              sectors[i].imageUrl,
                              width: double.infinity,
                              height: 50,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              sectors[i].title,
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: darkText),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rekomendasi Pembelajaran",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkText),
                  ),
                  Text(
                    "Lihat Semua",
                    style: GoogleFonts.mulish(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    for (var i = 0; i < 5; i++)
                      Container(
                        width: 300,
                        padding: const EdgeInsets.only(
                          left: 20,
                          bottom: 20,
                        ),
                        child: CourseCard(
                          onTap: () {
                            Get.toNamed("/course-detail");
                          },
                          title: "Kursus",
                          imageUrl: "https://picsum.photos/200/300?random=$i",
                          description: "Kursus ini akan membantu anda",
                        ),
                      ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class Sectors {
  final String title;
  final String imageUrl;
  final String url;

  Sectors({required this.title, required this.imageUrl, this.url = ""});
}
