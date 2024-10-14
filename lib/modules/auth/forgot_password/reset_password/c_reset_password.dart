import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';

import '../../../../_common/data/data_controller.dart';
import '../../../../_servies/network_services/api_endpoint.dart';
import '../forgot_password_verification/c_forgot_password_verification_page.dart';

class ResetPasswordController extends GetxController {
  String strResetToken = '';
  TextEditingController txtNewPassword = TextEditingController(text: '');
  TextEditingController txtReNewPassword = TextEditingController(text: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    ForgotVerificationController forgotVerificationController = Get.find();
    strResetToken = forgotVerificationController.strResetToken;
  }

  void checkAllField() {
    if (txtNewPassword.text.isEmpty) {
      maxMessageDialog('Please Enter New Password.');
    } else if (txtReNewPassword.text.isEmpty) {
      maxMessageDialog('Please Enter Confirm New Password.');
    }
  }

  void proceedToReset() {
    checkAllField();
    if (txtNewPassword.text.isNotEmpty && txtReNewPassword.text.isNotEmpty) {
      if (txtNewPassword.text == txtReNewPassword.text) {
        resetPassword();
      } else {
        maxMessageDialog('Password Didn\'t Match.');
      }
    }
  }

  Future<void> resetPassword() async {
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authResetPassword;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      final response = await client.post(
        url,
        {
          "newPassword": txtNewPassword.text,
          "comfirmNewPassword": txtReNewPassword.text
        },
        headers: {
          'Authorization': 'Bearer $strResetToken',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(response.body['message'].toString(), true);
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAll(() => const LoginPage());
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }
}

// headers: {
//         "accept": "*/*",
//         "Content-Type": "application/json",
//         if (xNeedToken) "Authorization": "Bearer ${dataController.apiToken}",
//       },
