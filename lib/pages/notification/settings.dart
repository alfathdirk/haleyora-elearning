import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/widget/card.dart';
import 'package:haleyora/widget/switch.dart';

class NotificationSetting extends StatelessWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
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
                  padding: EdgeInsets.all(20.0),
                  child: CustomCard(
                    // label with icon and arrow right icon
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: ListBody(
                        children: [
                          ListTile(
                            title: Text('Email',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: SwitchCustom(
                              value: false,
                              onChanged: (value) {},
                            ),
                            onTap: () {
                              // navigate to edit profile page
                              Get.toNamed("/form-profile");
                            },
                          ),
                          ListTile(
                            title: Text('New Course',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: SwitchCustom(
                              value: false,
                              onChanged: (value) {},
                            ),
                            onTap: () {
                              // navigate to edit profile page
                              Get.toNamed("/form-profile");
                            },
                          ),
                          ListTile(
                            title: Text('Sound',
                                style: GoogleFonts.mulish(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: SwitchCustom(
                              value: false,
                              onChanged: (value) {},
                            ),
                            onTap: () {
                              // navigate to edit profile page
                              Get.toNamed("/form-profile");
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
