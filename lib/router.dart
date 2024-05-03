import 'package:haleyora/middleware.dart';
import 'package:haleyora/pages/categories/list.dart';
import 'package:haleyora/pages/course/detail.dart';
import 'package:haleyora/pages/course/video_course.dart';
import 'package:haleyora/pages/filter/filter.dart';
import 'package:haleyora/pages/home.dart';
import 'package:haleyora/pages/notification/detail.dart';
import 'package:haleyora/pages/notification/list.dart';
import 'package:haleyora/pages/notification/settings.dart';
import 'package:haleyora/pages/profile/edit_password.dart';
import 'package:haleyora/pages/profile/form.dart';
import 'package:haleyora/pages/quiz/quiz.dart';
import 'package:haleyora/pages/sector/list.dart';
import 'package:haleyora/pages/task/task.dart';
import 'pages/auth/login.dart';
import 'package:get/get.dart';

class Routes {
  static String homePage = "/home";
  static String loginPage = "/login";
  static String courseDetail = "/course-detail/:id";
  static String videoPlayer = "/video-player/:url";
  static String quizPage = "/quiz";
  static String listSector = "/list-sector";
  static String notificationList = "/notification";
  static String notificationDetail = "/notification-detail";
  static String formProfile = "/form-profile";
  static String notificationSetting = "/notification-setting";
  static String categoryList = "/category-list/:name";
  static String filterPage = "/filter";
  static String editPassword = "/edit-password";
  static String taskDetail = "/task-detail/:id";
}

final pages = [
  GetPage(
      name: Routes.homePage,
      page: () => HomeScreen(),
      middlewares: [AuthMiddleware()]),
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
    page: () => VideoPlayerApp(),
  ),
  GetPage(
    name: Routes.quizPage,
    page: () => QuizPage(),
  ),
  GetPage(
    name: Routes.listSector,
    page: () => ListSector(),
  ),
  GetPage(
    name: Routes.notificationList,
    page: () => NotificationList(),
  ),
  GetPage(
    name: Routes.notificationSetting,
    page: () => NotificationSetting(),
  ),
  GetPage(
    name: Routes.notificationDetail,
    page: () => DetailPage(),
  ),
  GetPage(
    name: Routes.formProfile,
    page: () => EditProfileForm(),
  ),
  GetPage(
    name: Routes.editPassword,
    page: () => EditPasswordPage(),
  ),
  GetPage(
    name: Routes.categoryList,
    page: () => CategoryListPage(),
  ),
  GetPage(
    name: Routes.filterPage,
    page: () => const FilterPage(),
  ),
  GetPage(
    name: Routes.taskDetail,
    page: () => TaskAssignment(),
  ),
];
