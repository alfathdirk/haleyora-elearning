import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller;

  AuthController authController = Get.find<AuthController>();
  final courseId = Get.parameters['courseId'];
  final lastVideoDuration = Get.arguments['lastVideoDuration'];
  bool isVideoReady = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        "https://www.youtube.com/watch?v=${widget.videoUrl}",
      )!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_controller.value.isReady && !isVideoReady) {
      isVideoReady = true;
      if (lastVideoDuration != null) {
        _controller.seekTo(Duration(seconds: lastVideoDuration));
      }
    }
  }

  @override
  void dispose() {
    dio.patch('/items/employee_course', data: {
      "query": {
        "filter": {
          "employee": {
            "_eq": authController.currentUser.value.employeeData!.id
          },
          "course": {"_eq": courseId}
        }
      },
      "data": {
        "last_video_duration": _controller.value.position.inSeconds,
        "video_duration": _controller.metadata.duration.inSeconds
      }
    });
    _controller.dispose();
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blue,
      ),
    );
  }
}
