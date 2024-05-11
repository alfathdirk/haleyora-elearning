import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {
  final RxBool isLoggedIn = false.obs;

  Future<AuthService> init() async {
    final box = GetStorage();
    final accessToken = box.read('accessToken');
    final refreshToken = box.read('refreshToken');
    if (accessToken != null && refreshToken != null) {
      setisLoggedIn(true);
    }
    return this;
  }

  void logout() {
    final box = GetStorage();
    box.remove('accessToken');
    box.remove('refreshToken');
    isLoggedIn.value = false;
  }

  Future<void> setisLoggedIn(bool newValue) async {
    isLoggedIn.value = newValue;
  }
}
