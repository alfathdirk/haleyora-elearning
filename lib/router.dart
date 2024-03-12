import 'package:haleyora/pages/home.dart';
import 'pages/auth/login.dart';
import 'package:get/get.dart';

/// used to declare all the routes in strings so that
/// we can navigate through only the page names
class Routes {
  static String homePage = "/home";
  static String loginPage = "/login";
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
];
