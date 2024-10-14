import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../_common/data/data_controller.dart';
import '../../../_servies/network_services/api_endpoint.dart';
import 'forgot_password_verification/v_forgot_password_verification_page.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController txtEmail = TextEditingController(text: '');
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    getEmail();
  }

  Future<void> sendOTP() async {
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authForgotPassword;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(url, {"email": txtEmail.text});

      Get.back();
      if (response.isOk) {
        Get.to(() => const ForgotVerificationPage());
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      txtEmail.text = email;
    } else {
      txtEmail.text = "";
    }
  }
}
