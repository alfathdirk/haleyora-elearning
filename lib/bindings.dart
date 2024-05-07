import 'package:get/get.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/controller/notification.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/widget/navigation_bar.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(CourseController());
    Get.put(QuizController());
    Get.put(NavigationController());
  }
}
