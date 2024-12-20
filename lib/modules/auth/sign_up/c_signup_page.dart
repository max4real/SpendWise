import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';

import '../verification/v_verification_page.dart';

class SignUpController extends GetxController {
  final ValueNotifier<bool> xObscured = ValueNotifier(true);
  final ValueNotifier<bool?> xChecked = ValueNotifier(false);

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtEmail = TextEditingController();
  final TextEditingController txtPassword = TextEditingController();

  String? validateFields() {
    if (txtName.text.isEmpty) return "Please enter your name.";
    if (txtEmail.text.isEmpty) return "Please enter your email.";
    if (txtPassword.text.isEmpty) return "Please enter your password.";
    if (xChecked.value != true) return "Please agree to the terms.";
    return null;
  }

  void proceedToVerification() {
    final errorMessage = validateFields();
    if (errorMessage != null) {
      maxMessageDialog(errorMessage);
      return;
    }
    makeRegister();
  }

  Future<void> makeRegister() async {
    final GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      final response = await client.post(
        '${ApiEndpoint.baseUrl}${ApiEndpoint.authRegister}',
        {
          "name": txtName.text,
          "email": txtEmail.text,
          "password": txtPassword.text,
        },
      );

      Get.back();

      if (response.isOk) {
        await saveEmail(txtEmail.text);
        Get.to(() => const VerificationPage());
      } else {
        maxSuccessDialog(
            response.body?['message']?.toString() ?? 'Unknown error', false);
      }
    } catch (e) {
      Get.back();
      maxMessageDialog('Failed to register. Please try again later.');
      debugPrint('Error in makeRegister: $e');
    }
  }

  Future<void> saveEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}
