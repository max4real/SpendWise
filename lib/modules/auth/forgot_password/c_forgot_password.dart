import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/forgot_password/forgot_password_verification/v_forgot_password_verification_page.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController txtEmail = TextEditingController(text: '');
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> sendOTP() async {
    Get.to(() => const ForgotVerificationPage());
  }
}
