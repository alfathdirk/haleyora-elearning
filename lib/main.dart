import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/firebase_options.dart';
import 'package:haleyora/services/auth_service.dart';
import 'package:haleyora/services/notification.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:haleyora/services/dio_client.dart';
import 'router.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void initServices() async {
  print('starting services ...');
  await Get.putAsync(() => GetStorage.init());
  await Get.putAsync(() => AuthService().init());
  await Get.putAsync(() => NotificationService().init());

  // TODO: need to add exam service to check timeout;
  print('All services started...');
}

void main(List<String> args) async {
  setPathUrlStrategy();
  initServices();
  configureDio();
  // disable screenshot and recording here
  // await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  // potrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (GetPlatform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  return runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
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
      },
    );
  }
}
