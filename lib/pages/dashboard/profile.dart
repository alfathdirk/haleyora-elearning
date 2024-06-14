import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:haleyora/widget/card.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Get.find<AuthService>();
    AuthController authController = Get.find<AuthController>();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Profile',
              style:
                  GoogleFonts.jost(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                    authController.currentUser.value.employeeData!.photo ??
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomCard(
                    // label with icon and arrow right icon
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListBody(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: Text('Detail Profil',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              // navigate to edit profile page
                              Get.toNamed("/detail-profile");
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.shield_moon_outlined),
                            title: Text('Keamanan',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                          // ListTile(
                          //   leading: const Icon(Icons.lock_outlined),
                          //   title: Text('Ubah Sandi',
                          //       style: GoogleFonts.mulish(
                          //           fontSize: 16, fontWeight: FontWeight.bold)),
                          //   trailing: const Icon(Icons.chevron_right),
                          //   onTap: () {
                          //     // navigate to edit password page
                          //     Get.toNamed("/edit-password");
                          //   },
                          // ),
                          ListTile(
                            leading: const Icon(Icons.shield_outlined),
                            title: Text('Syarat dan Ketentuan',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                          ListTile(
                            leading:
                                const Icon(Icons.power_settings_new_outlined),
                            title: Text('Keluar',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => {
                              // show dialog confirmation
                              Get.defaultDialog(
                                title: "Konfirmasi",
                                backgroundColor: Colors.white,
                                middleText: "Apakah Anda yakin ingin keluar?",
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Batal'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      authService.logout();
                                      Get.offAllNamed('/login');
                                    },
                                    child: const Text('Keluar'),
                                  ),
                                ],
                              )
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
