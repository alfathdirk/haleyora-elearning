import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/chart.dart';

class AchievmentPage extends StatelessWidget {
  const AchievmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text(
              "Pencapaian",
              style: GoogleFonts.jost(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CustomCard(
                          height: 150,
                          child: Stack(
                            children: [
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const ProgressPieChart(
                                    0.25,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                        "25",
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
                              Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Icon(
                                    Icons.emoji_events_outlined,
                                    color: Colors.grey[100],
                                    size: 100,
                                  )),
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
                for (var i = 0; i < 3; i++)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomCard(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Image.network(
                              'https://picsum.photos/50/50',
                              width: 50,
                              height: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Yantek | Operasi Sistem",
                                  style: GoogleFonts.mulish(
                                    color: orangeText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                  ),
                                ),
                                Text(
                                  "Flutter Fundamental",
                                  style: GoogleFonts.mulish(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(bottom: 8, top: 8),
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
                                        " 80",
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
                                      MediaQuery.of(context).size.width / 1.4,
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
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "LIHAT SERTIFIKAT",
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
                                          )
                                        ],
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
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
