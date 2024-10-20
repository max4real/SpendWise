import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/v_login_gateway.dart';
import 'package:spend_wise/modules/main_page/v_main_page.dart';

import '../../_servies/network_services/api_endpoint.dart';

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
        Get.offAll(() => const MainPage());
      } else {
        print('Token - ' + token_);
        print('2');
        Get.offAll(() => const LoginPage());
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
    String meUrl = ApiEndpoint.baseUrl2 + ApiEndpoint.meAPI;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    final meResponse = await client.get(
      meUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (meResponse.isOk) {
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
