import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: darkText),
                                ),
                                Text(
                                  "John Doe",
                                  style: GoogleFonts.poppins(
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
                            Get.snackbar("Hello", "This is a message");
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
                    style: GoogleFonts.poppins(fontSize: 10, color: darkText),
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
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 12, color: greyText),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.filter_alt_outlined,
                      color: greyText,
                    )
                  ],
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
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
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
                  for (var i = 0; i < 3; i++)
                    CustomCard(
                      child: InkWell(
                        onTap: () {
                          Get.toNamed("/detail");
                        },
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.book,
                              size: 30,
                              color: primaryColor,
                            ),
                            Text(
                              "Kursus",
                              style: TextStyle(
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
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: darkText),
                  ),
                  Text(
                    "Lihat Semua",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: primaryColor),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height / 4,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 20),
                      child: CustomCard(
                        child: SizedBox(
                          width: 280,
                          child: Text("Kursus 1"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 20),
                      child: CustomCard(
                        child: SizedBox(
                          width: 280,
                          child: Text("Kursus 1"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 20),
                      child: CustomCard(
                        child: SizedBox(
                          width: 280,
                          child: Text("Kursus 1"),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
