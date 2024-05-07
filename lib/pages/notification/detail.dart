import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/notification.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key});
  NotificationData arguments = Get.arguments;
  NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(arguments.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await notificationController.getListNotification();
            Get.back();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Text(arguments.description),
      ),
    );
  }
}
