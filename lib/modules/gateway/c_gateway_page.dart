import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/v_login_gateway.dart';
import 'package:spend_wise/modules/home/v_home_page.dart';

class GatewayController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> initLoad() async {
    await getEmail();
    await getToken();
    await Future.delayed(const Duration(milliseconds: 500));
    if (token_ != '') {
      if (await checkToken(token_)) {
        print('Token - ' + token_);
        print('1');
        Get.offAll(() => const HomePage());
      } else {
        print('Token - ' + token_);
        print('2');
        Get.offAll(() => const LoginGatewayPage());
      }
    } else {
      if (email_ == '') {
        print('Token - ' + token_);
        print('3');
        Get.offAll(() => const LoginGatewayPage());
      } else {
        print('Token - ' + token_);
        print('4');
        Get.off(() => const LoginPage());
      }
    }
  }

  Future<bool> checkToken(String? token) async {
    // String url = '';
    if (token=='hi') {
      return true;
    } else {
      return false;
    }
  }

  String email_ = '';
  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      email_ = email;
    } else {
      email_ = "";
    }
  }

  String token_ = '';
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      token_ = token;
    } else if (token == null) {
      token_ = '';
    }
  }
}
