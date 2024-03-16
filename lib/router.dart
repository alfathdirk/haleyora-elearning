import 'package:haleyora/pages/course/detail.dart';
import 'package:haleyora/pages/course/video_course.dart';
import 'package:haleyora/pages/home.dart';
import 'pages/auth/login.dart';
import 'package:get/get.dart';

/// used to declare all the routes in strings so that
/// we can navigate through only the page names
class Routes {
  static String homePage = "/home";
  static String loginPage = "/login";
  static String courseDetail = "/course-detail";
  static String videoPlayer = "/video-player";
}

/// assign this list variable into your GetMaterialApp as the value of getPages parameter.
/// you can get the reference to the above GetMaterialApp code.
final pages = [
  GetPage(
    name: Routes.homePage,
    page: () => HomeScreen(),
  ),
  GetPage(
    name: Routes.loginPage,
    page: () => const LoginScreen(),
  ),
  GetPage(
    name: Routes.courseDetail,
    page: () => CourseDetail(),
  ),
  GetPage(
    name: Routes.videoPlayer,
    page: () => const VideoPlayerApp(),
  ),
];
