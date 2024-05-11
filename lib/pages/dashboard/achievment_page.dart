import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/chart.dart';
import 'package:haleyora/widget/pdf.dart';

class AchievmentPage extends StatelessWidget {
  AchievmentPage({super.key});
  CourseController courseController = Get.find<CourseController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          courseController.getCourseByEmployee(box.read('employee_id'), null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return buildWidget(context);
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pencapaian",
            style: GoogleFonts.jost(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
          ),
          centerTitle: false,
          titleSpacing: 20,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomCard(
                            height: 150,
                            child: Stack(
                              children: [
                                Positioned(
                                    right: 0,
                                    bottom: 0,
                                    child: Icon(
                                      Icons.emoji_events_outlined,
                                      color: Colors.grey[100],
                                      size: 100,
                                    )),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ProgressPieChart(
                                      examScores: courseController
                                                  .courseByEmployee
                                                  .value
                                                  .data !=
                                              null
                                          ? courseController
                                              .courseByEmployee.value.data!
                                              .map((e) => e.course!.minScore)
                                              .reduce((value, element) =>
                                                  value! + element!)
                                              ?.toDouble()
                                          : 0,
                                      employeeScore: courseController
                                                  .courseByEmployee
                                                  .value
                                                  .data !=
                                              null
                                          ? courseController
                                              .courseByEmployee.value.data!
                                              .map((e) => e.examScore)
                                              .reduce((value, element) =>
                                                  value! + element!)
                                              ?.toDouble()
                                          : 0,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Total Kursus",
                                          style: GoogleFonts.mulish(
                                            color: greyText,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          "${courseController.courseByEmployee.value.data!.length}",
                                          style: GoogleFonts.mulish(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 180,
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
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Kursus yang sedang diikuti",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.jost(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount:
                          courseController.courseByEmployee.value.data!.length,
                      itemBuilder: (context, index) {
                        ;
                        if (courseController.courseByEmployee.value.data![index]
                                .examScore ==
                            0) {
                          return SizedBox();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(
                              bottom: 12, left: 16, right: 16),
                          child: CustomCard(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.orange[50],
                                    ),
                                    child: const Icon(
                                      Icons.emoji_events_outlined,
                                      color: Colors.orange,
                                      size: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${courseController.courseByEmployee.value.data![index].course!.activities?.title}",
                                        style: GoogleFonts.mulish(
                                          color: orangeText,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 9,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.6,
                                        child: Text(
                                          "${courseController.courseByEmployee.value.data![index].course!.title}",
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 3,
                                          style: GoogleFonts.mulish(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8, top: 8),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Nilai Test:",
                                              style: GoogleFonts.mulish(
                                                color: greyText,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              " ${courseController.courseByEmployee.value.data![index].examScore}",
                                              style: GoogleFonts.mulish(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.47,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "ULANGI TEST",
                                                  style: GoogleFonts.mulish(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: primaryColor,
                                                  size: 10,
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () async {
                                                await PDF.generate();
                                              },
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "LIHAT SERTIFIKAT",
                                                    style: GoogleFonts.mulish(
                                                      color: primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: primaryColor,
                                                    size: 10,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
