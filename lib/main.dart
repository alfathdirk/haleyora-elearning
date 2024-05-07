import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/controller/auth.dart';
import 'package:haleyora/controller/course.dart';
import 'package:haleyora/controller/quiz.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:haleyora/services/dio_client.dart';
import 'router.dart';

void initServices() async {
  print('starting services ...');
  await Get.putAsync(() => GetStorage.init());
  await Get.putAsync(() => AuthService().init());
  // TODO: need to add exam service to check timeout;
  // await Get.putAsync(() => ExamService().init());
  print('All services started...');
}

void main(List<String> args) async {
  setPathUrlStrategy();
  initServices();
  configureDio();
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'E-learning App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.homePage,
      defaultTransition: Transition.rightToLeft,
      getPages: pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
