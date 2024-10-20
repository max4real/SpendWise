import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';

class ProfileController extends GetxController {
  String name = "Max_4_Real";
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void logOut() {
    removeToken();
    Get.offAll(() => const LoginPage());
  }

  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', '');
  }
}
