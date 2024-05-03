import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:haleyora/router.dart';
import 'package:haleyora/services/auth_service.dart';

class AuthMiddleware extends GetMiddleware {
  final authService = Get.find<AuthService>();

  @override
  RouteSettings? redirect(String? route) {
    return authService.isLoggedIn.value
        ? null
        : RouteSettings(name: Routes.loginPage);
  }
}
