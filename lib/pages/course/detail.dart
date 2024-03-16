import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';

class CourseDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.7,
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
                          icon: Icon(Icons.arrow_back),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: greyText,
                                            size: 10,
                                          ),
                                          Text(
                                            '4.5',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time,
                                            color: greyText,
                                            size: 10,
                                          ),
                                          Text(
                                            '2h 30m',
                                            style: GoogleFonts.mulish(
                                                fontSize: 10,
                                                fontWeight: FontWeight.normal,
                                                color: greyText,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    height: 2,
                                    color: Colors.grey[100],
                                  ),
                                  SizedBox(height: 20),
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
                                            decoration: TextDecoration.none),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus.',
                                        style: GoogleFonts.mulish(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: greyText,
                                            decoration: TextDecoration.none),
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
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(95, 165, 165, 165),
                                  blurRadius: 11,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    CupertinoIcons.pencil_ellipsis_rectangle,
                                    color: greyText,
                                    size: 40,
                                  ),
                                  Text(
                                    'Mulai Ujian',
                                    style: GoogleFonts.mulish(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(95, 165, 165, 165),
                                  blurRadius: 11,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.note_alt_outlined,
                                    color: greyText,
                                    size: 40,
                                  ),
                                  Text(
                                    'Tugas',
                                    style: GoogleFonts.mulish(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        decoration: TextDecoration.none),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Icon(
                            Icons.picture_as_pdf_outlined,
                            color: greyText,
                            size: 30,
                          ),
                        ],
                      ),
                      SizedBox(width: 10),
                      Container(
                          width: MediaQuery.of(context).size.width - 100,
                          child: RoundedButton(
                              text: 'Mulai Video', onPressed: () {}))
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
