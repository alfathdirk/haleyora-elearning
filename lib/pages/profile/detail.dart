import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:haleyora/widget/card.dart';

class ProfileDetailPage extends StatelessWidget {
  AuthService authService = Get.find<AuthService>();
  AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Detail'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                loadingBuilder: (context, child, progress) {
                  return progress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
                'https://i.pinimg.com/originals/7c/c7/a6/7cc7a630624d20f7797cb4c8e93c09c1.png',
                fit: BoxFit.cover,
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              authController.currentUser.value.employeeData!.fullName ?? '',
              style: GoogleFonts.mulish(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Text(
              authController.currentUser.value.employeeData!.email ?? '',
              style: GoogleFonts.mulish(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: CustomCard(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Status Kerja',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Aktif',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Nomor Induk',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('123456',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Region',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Jawa Barat',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Jabatan',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Staff',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Pekerjaan',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Staff',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Unit',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Unit 1',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Unit PLN',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Unit 1',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Penempatan',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Kantor Pusat',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Jenis Kelamin',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Laki-laki',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Tempat Lahir',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Jakarta',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Tanggal Lahir',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('01-01-1990',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Alamat KTP',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('Jl. Kebon Jeruk No. 1',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                      ListTile(
                        title: Text('Nomor HP',
                            style: GoogleFonts.mulish(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        subtitle: Text('08123456789',
                            style: GoogleFonts.mulish(
                                fontSize: 14, fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
