import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';

import '../verification/v_verification_page.dart';

class SignUpController extends GetxController {
  ValueNotifier<bool> xObscured = ValueNotifier(true);
  ValueNotifier<bool?> xChecked = ValueNotifier(false);
  ValueNotifier<bool> xFetching = ValueNotifier(false);

  TextEditingController txtName = TextEditingController(text: '');
  TextEditingController txtEmail = TextEditingController(text: '');
  TextEditingController txtPassword = TextEditingController(text: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {}

  void checkAllField() {
    if (txtName.text.isEmpty) {
      maxMessageDialog('Please Enter Name.');
    } else if (txtEmail.text.isEmpty) {
      maxMessageDialog('Please Enter Email.');
    } else if (txtPassword.text.isEmpty) {
      maxMessageDialog('Please Enter Password.');
    } else if (xChecked.value == false) {
      maxMessageDialog('Please Check The Box');
    }
  }

  void proceedToVarification() {
    checkAllField();
    if (txtName.text.isNotEmpty &&
        txtEmail.text.isNotEmpty &&
        txtPassword.text.isNotEmpty &&
        xChecked.value == true) {
      makeRegister();
    }
  }

  Future<void> makeRegister() async {
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authRegister;
    xFetching.value = false;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));

      final response = await client.post(url, {
        "email": txtEmail.text,
        "password": txtPassword.text,
        "name": txtName.text,
      });

      Get.back();
      if (response.isOk) {
        print(response.body['message'].toString());
        saveEmail(txtEmail.text);
        Get.to(() => const VerificationPage());
      } else {
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
  }
}
