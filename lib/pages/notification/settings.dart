import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/widget/button.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/switch.dart';

class Controller extends GetxController {
  final RxBool emailValue = false.obs;
  final RxBool newCourseValue = false.obs;
  final RxBool soundValue = false.obs;
  void changeEmailValue(bool value) {
    emailValue.value = value;
  }

  void changeNewCourseValue(bool value) {
    newCourseValue.value = value;
  }

  void changeSoundValue(bool value) {
    soundValue.value = value;
  }
}

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());

    Future dialogSuccess() {
      return Get.defaultDialog(
          title: '',
          backgroundColor: Colors.white,
          contentPadding:
              const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
          content: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  loadingBuilder: (context, child, progress) {
                    return progress == null
                        ? child
                        : const Center(
                            child: CircularProgressIndicator(),
                          );
                  },
                  'https://picsum.photos/300/300',
                  fit: BoxFit.cover,
                  width: 180,
                  height: 180,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Edit Akun Berhasil",
                style: GoogleFonts.jost(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: double.infinity,
                child: RoundedButton(
                    text: "Tutup",
                    onPressed: () {
                      Get.back();
                    }),
              )
            ],
          ));
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              dialogSuccess();
              // Navigator.pop(context);
            },
          ),
          title: Text('Notifikasi',
              style:
                  GoogleFonts.jost(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomCard(
                    // label with icon and arrow right icon
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Obx(() => ListBody(
                            children: [
                              ListTile(
                                title: Text('Email',
                                    style: GoogleFonts.mulish(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                trailing: SwitchCustom(
                                  value: c.emailValue.value,
                                  onChanged: (value) {
                                    c.changeEmailValue(value);
                                  },
                                ),
                                onTap: () {
                                  // navigate to edit profile page
                                  Get.toNamed("/form-profile");
                                },
                              ),
                              ListTile(
                                title: Text('New Course',
                                    style: GoogleFonts.mulish(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                trailing: SwitchCustom(
                                  value: c.newCourseValue.value,
                                  onChanged: (value) {
                                    c.changeNewCourseValue(value);
                                  },
                                ),
                                onTap: () {
                                  // navigate to edit profile page
                                  Get.toNamed("/form-profile");
                                },
                              ),
                              ListTile(
                                title: Text('Sound',
                                    style: GoogleFonts.mulish(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                trailing: SwitchCustom(
                                  value: c.soundValue.value,
                                  onChanged: (value) {
                                    c.changeSoundValue(value);
                                  },
                                ),
                                onTap: () {
                                  // navigate to edit profile page
                                  Get.toNamed("/form-profile");
                                },
                              ),
                            ],
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
