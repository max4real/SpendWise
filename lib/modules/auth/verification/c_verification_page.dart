import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/sign_up/c_signup_page.dart';

import '../../../_common/data/data_controller.dart';

class VerificationController extends GetxController {
  String strEmail = '';

  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ValueNotifier<int> remainingSeconds = ValueNotifier(60);
  ValueNotifier<bool> xSendAgain = ValueNotifier(false);

  Timer? timer;
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
    timer?.cancel();
  }

  void initLoad() {
    startCountdown();
    SignUpController signUpController = Get.find();
    strEmail = signUpController.txtEmail.text;
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        xSendAgain.value = true;
        timer.cancel();
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> varifyEmail(String? pin) async {
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        ),
      );

      final response = await client.post(
        ApiEndpoint.baseUrl + ApiEndpoint.authVerifyEmail,
        {
          "email": strEmail,
          "code": pin,
        },
      );

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(response.body['message'].toString(), true);
        Get.offAll(() => const LoginPage());
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }

  void sendCodeAgain() {
    if (xSendAgain.value) {
      xSendAgain.value = false;
      sendOTPAgain();
      remainingSeconds.value = 60;
      startCountdown();
    }
  }

  Future<void> sendOTPAgain() async {
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(
        ApiEndpoint.baseUrl + ApiEndpoint.authResendOTP,
        {
          "email": strEmail,
          "purpose": "SIGNUP",
        },
      );

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(response.body['message'].toString(), true);
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }
}
