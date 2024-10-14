import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/modules/auth/forgot_password/c_forgot_password.dart';
import 'package:spend_wise/modules/auth/forgot_password/reset_password/v_reset_password.dart';

import '../../../../_common/data/data_controller.dart';

class ForgotVerificationController extends GetxController {
  String strEmail = '';
  String strResetToken = '';

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
    ForgotPasswordController forgotPasswordController = Get.find();
    strEmail = forgotPasswordController.txtEmail.text;
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
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authVerifyOTP;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(url, {"code": pin});

      Get.back();
      if (response.isOk) {
        String resetToken = response.body["resetToken"].toString();
        strResetToken = resetToken;
        Get.to(() => const ResetPasswordPage());
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }

  void sendCodeAgain() {
    if (xSendAgain.value) {
      xSendAgain.value = false;
      sendOTP();
      remainingSeconds.value = 60;
      startCountdown();
    }
  }

  Future<void> sendOTP() async {
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authForgotPassword;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(url, {"email": strEmail});

      Get.back();
      if (response.isOk) {
        maxSuccessDialog(response.body['message'].toString(), true);
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }
}
