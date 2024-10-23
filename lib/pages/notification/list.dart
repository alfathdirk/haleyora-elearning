import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:haleyora/controller/notification.dart';
import 'package:haleyora/widget/card.dart';
import 'package:intl/intl.dart';

class NotificationList extends StatelessWidget {
  NotificationList({super.key});
  NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: notificationController.getListNotification(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Obx(() => buildWidget(context));
        }
      },
    );
  }

  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: notificationController.listNotification
            .length, // Replace with the actual number of notifications
        itemBuilder: (context, index) {
          final notif = notificationController.listNotification[index];
          final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
          final String formatted = formatter.format(notif.time);

          return Container(
            padding: const EdgeInsets.all(20),
            child: CustomCard(
              color: notif.isRead! ? Colors.white : Colors.blue[200],
              child: ListTile(
                title: Text(notif.title,
                    style: GoogleFonts.mulish(fontWeight: FontWeight.bold)),
                subtitle: Text(notif.description,
                    style: GoogleFonts.mulish(
                        fontSize: 12.sp, color: Colors.black)),
                // trailing time
                trailing:
                    Text(formatted, style: GoogleFonts.mulish(fontSize: 9)),
                onTap: () {
                  if (!notif.isRead!) {
                    notificationController.readNotification(notif.id);
                  }
                  Get.toNamed('/notification-detail', arguments: notif);
                  // Handle notification tap
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
