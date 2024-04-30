import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final dio = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8055',
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ),
);

void configureDio() {
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
      Get.showSnackbar(
        const GetSnackBar(
          title: 'Error',
          message: 'something went wrong!',
          icon: Icon(Icons.refresh),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    },
  ));
}
