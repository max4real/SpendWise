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
  ValueNotifier<bool> xFetching = ValueNotifier(false);

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

  // String? validateCode(String? value) {
  //   if (value == '222222') {
  //     print(value);
  //     return null;
  //   } else {
  //     print(value);
  //     return 'Incorrect Pin';
  //   }
  // }

  Future<void> varifyEmail(String? pin) async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.authVerifyEmail2;
    xFetching.value = false;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      ));

      final response = await client.post(url, {"email": strEmail, "code": pin});

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), true);
        Get.offAll(() => const LoginPage());
      } else {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e1) {}
  }

  void sendCodeAgain() {
    if (xSendAgain.value) {
      xSendAgain.value = false;
      print('send again');
      sendOTPAgain();
      remainingSeconds.value = 60;
      startCountdown();
    } else {
      print("not now");
    }
  }

  Future<void> sendOTPAgain() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.authResendOTP2;
    xFetching.value = false;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(url, {"email": strEmail});

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), true);
      } else {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e1) {}
  }
}
