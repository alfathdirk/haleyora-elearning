import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/pages/auth/model.dart';
import 'package:haleyora/services/dio_client.dart';

class AuthController extends GetxController {
  final currentUser = UserData().obs;

  @override
  void onInit() async {
    await getMe();
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getMe() async {
    try {
      print('get me fetched...');
      final value = await dio.get('/users/me');
      Map<String, dynamic> jsonResponse = json.decode(value.toString());
      UserData userData = UserData.fromJson(jsonResponse['data']);
      currentUser.value = userData;
    } catch (e) {
      print('error getMe: $e');
      // if(e.response.statusCode == 401) {
      //   final value = await dio.post('/auth/refresh-token', data: {
      //     'refreshToken': refreshToken,
      //   });
      //   Map<String, dynamic> jsonResponse = json.decode(value.toString());
      //   final newAccessToken = jsonResponse['data']['accessToken'];
      //   final newRefreshToken = jsonResponse['data']['refreshToken'];
      //   final box = GetStorage();
      //   box.write('accessToken', newAccessToken);
      //   box.write('refreshToken', newRefreshToken);
      //   getMe(newAccessToken, newRefreshToken);
      // }
    }
  }
}
