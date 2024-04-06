import 'package:haleyora/pages/categories/list.dart';
import 'package:haleyora/pages/course/detail.dart';
import 'package:haleyora/pages/course/video_course.dart';
import 'package:haleyora/pages/filter/filter.dart';
import 'package:haleyora/pages/home.dart';
import 'package:haleyora/pages/notification/detail.dart';
import 'package:haleyora/pages/notification/list.dart';
import 'package:haleyora/pages/notification/settings.dart';
import 'package:haleyora/pages/profile/form.dart';
import 'package:haleyora/pages/quiz/quiz.dart';
import 'package:haleyora/pages/sector/list.dart';
import 'pages/auth/login.dart';
import 'package:get/get.dart';

/// used to declare all the routes in strings so that
/// we can navigate through only the page names
class Routes {
  static String homePage = "/home";
  static String loginPage = "/login";
  static String courseDetail = "/course-detail";
  static String videoPlayer = "/video-player";
  static String quizPage = "/quiz";
  static String listSector = "/list-sector";
  static String notificationList = "/notification";
  static String notificationDetail = "/notification-detail";
  static String formProfile = "/form-profile";
  static String notificationSetting = "/notification-setting";
  static String categoryList = "/category-list/:name";
  static String filterPage = "/filter";
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
    page: () => const CourseDetail(),
  ),
  GetPage(
    name: Routes.videoPlayer,
    page: () => const VideoPlayerApp(),
  ),
  GetPage(
    name: Routes.quizPage,
    page: () => QuizPage(),
  ),
  GetPage(
    name: Routes.listSector,
    page: () => const ListSector(),
  ),
  GetPage(
    name: Routes.notificationList,
    page: () => const NotificationList(),
  ),
  GetPage(
    name: Routes.notificationSetting,
    page: () => const NotificationSetting(),
  ),
  GetPage(
    name: Routes.notificationDetail,
    page: () => const DetailPage(),
  ),
  GetPage(
    name: Routes.formProfile,
    page: () => const EditProfileForm(),
  ),
  GetPage(
    name: Routes.categoryList,
    page: () => CategoryListPage(),
  ),
  GetPage(
    name: Routes.filterPage,
    page: () => const FilterPage(),
  ),
];
