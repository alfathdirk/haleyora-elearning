import 'package:flutter/material.dart';
import 'package:haleyora/widget/video_player.dart';

class VideoPlayerApp extends StatelessWidget {
  const VideoPlayerApp({super.key});

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
              videoUrl:
                  'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
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
