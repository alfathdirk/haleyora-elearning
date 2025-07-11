import 'dart:math';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/model/me.dart';
import 'package:haleyora/services/dio_client.dart';
import 'dart:developer' as developer;

class AuthController extends GetxController {
  final currentUser = ResponseData().obs;

  @override
  void onInit() async {
    await getMe();
    super.onInit();
  }

  Future<void> getMe() async {
    try {
      final box = GetStorage();
      print('get me fetched...');
      final resultMe = await dio.get('/api/me');
      final userData = ResponseData.fromJson(resultMe.data['message']);
      box.write('employee_id', currentUser.value.employeeData?.id);
      box.write('id_region', currentUser.value.employeeData?.idRegion);
      box.write('job', currentUser.value.employeeData?.job);
      box.write('unit', currentUser.value.employeeData?.unit);
      box.write('unit_pln', currentUser.value.employeeData?.unitPLN);
      box.write('position', currentUser.value.employeeData?.position);

      currentUser.value = userData;
    } catch (e) {
      developer.log('error getMe: ${e.toString()}');
    }
  }
}
