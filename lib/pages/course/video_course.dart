import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/widget/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  VideoPlayerApp({super.key});
  String dataUrl = Get.parameters['url']!;
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: double.infinity,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: [
            VideoPlayerWidget(
              videoUrl: dataUrl,
            ),
            Positioned(
              top: 20,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
