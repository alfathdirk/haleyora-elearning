import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/constants.dart';
import 'package:haleyora/services/auth_service.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: apiURL,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);

void configureDio() {
  // dio.interceptors.add(AwesomeDioInterceptor());
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final box = GetStorage();
      final accessToken = box.read('accessToken');
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
      return handler.next(options);
    },
    onError: (DioError e, handler) {
      if (e.response?.statusCode == 401) {
        final authService = Get.find<AuthService>();
        authService.logout();
        Get.offAllNamed('/login');
      }
      print('e >>>>>: $e');
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'something went wrong!',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
      // return handler.next(e);
    },
  ));
}
