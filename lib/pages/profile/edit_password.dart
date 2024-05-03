import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/text_input.dart';

class EditPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Simulating obtaining the user name from some local storage
    print('object');
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  String validator(String value) {
    if (value.isEmpty) {
      return 'Please this field must be filled';
    }
    return '';
  }

  void changePassword() {}
}

class EditPasswordPage extends StatelessWidget {
  const EditPasswordPage({super.key});

  void save() {
    // save to api
  }

  @override
  Widget build(BuildContext context) {
    final EditPasswordController controller = Get.put(EditPasswordController());
    return Scaffold(
      appBar: AppBar(
          title: const Text('Ubah Sandi'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sandi Lama',
              style: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithBoxShadow(
              controller: controller.currentPasswordController,
              labelText: 'Sandi Lama',
              isPassword: true,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Sandi Baru',
              style: GoogleFonts.mulish(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldWithBoxShadow(
              controller: controller.newPasswordController,
              labelText: 'Sandi Baru',
              isPassword: true,
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldWithBoxShadow(
              controller: controller.confirmPasswordController,
              labelText: 'Konfirmasi Sandi Baru',
              isPassword: true,
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: RoundedButton(
                text: 'Simpan',
                onPressed: () {
                  controller.changePassword();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
