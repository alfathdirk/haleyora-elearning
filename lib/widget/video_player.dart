import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/services/dio_client.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  AuthController authController = Get.find<AuthController>();
  final courseId = Get.parameters['courseId'];
  final lastVideoDuration = Get.arguments['lastVideoDuration'];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    // _controller.setLooping(false);
    // _controller.play();
    _initializeVideoPlayerFuture = _controller.initialize();
    _initializeVideoPlayerFuture.then((value) {
      if (lastVideoDuration != null) {
        _controller.seekTo(Duration(seconds: lastVideoDuration));
      }
      _controller.play();
    });
    // _controller.seekTo(Duration(seconds: lastVideoDuration));
  }

  @override
  void dispose() {
    _controller.position.then((value) {
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
          "last_video_duration": value!.inSeconds,
          "video_duration": _controller.value.duration.inSeconds
        }
      });
    });
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Stack(
            children: [
              ValueListenableBuilder(
                valueListenable: _controller,
                builder: (context, VideoPlayerValue value, child) {
                  return Container(
                    color: const Color.fromARGB(255, 240, 240, 240),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  );
                },
              ),
              Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 70,
                      height: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: VideoProgressIndicator(_controller,
                            padding: const EdgeInsets.all(0),
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              playedColor: Colors.blue,
                              bufferedColor: Colors.grey,
                              backgroundColor: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
