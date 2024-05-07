import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haleyora/model/me.dart';
import 'package:haleyora/services/dio_client.dart';

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
      currentUser.value = userData;
    } catch (e) {
      print('error getMe: $e');
    }
  }
}
