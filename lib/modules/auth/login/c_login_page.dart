import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';

import '../../../_common/data/data_controller.dart';
import '../../main_page/v_main_page.dart';

class LoginPageController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<bool> xObscured = ValueNotifier(true);
  TextEditingController txtEmail = TextEditingController(text: '');
  TextEditingController txtPassword = TextEditingController(text: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    getEmail();
  }

  void checkAllField() {
    if (txtEmail.text.isEmpty) {
      maxMessageDialog('Please Enter Email.');
    } else if (txtPassword.text.isEmpty) {
      maxMessageDialog('Please Enter Password.');
    }
  }

  void proceedToLogin() {
    checkAllField();
    if (txtEmail.text.isNotEmpty && txtPassword.text.isNotEmpty) {
      makeLogin();
    }
  }

  Future<void> makeLogin() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.authLogin2;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client
          .post(url, {"email": txtEmail.text, "password": txtPassword.text});

      Get.back();
      if (response.isOk) {
        String token = response.body["_data"]['token'].toString();
        dataController.apiToken = token;
        saveToken(token);
        saveEmail(txtEmail.text);

        print('Saved Email - ' + txtEmail.text);
        print('Saved Token - ' + token);

        String meUrl = ApiEndpoint.baseUrl2 + ApiEndpoint.meAPI;
        final meResponse = await client.get(
          meUrl,
          headers: {
            'Authorization': 'Bearer ${dataController.apiToken}',
            'Content-Type': 'application/json',
          },
        );

        if (meResponse.isOk) {
          Get.offAll(() => const MainPage());
          // maxSuccessDialog(
          //     '${meResponse.body['_data']['name']}\n${meResponse.body['_data']['email']}',
          //     true);
        } else {
          maxSuccessDialog(
              meResponse.body['_metadata']['message'].toString(), false);
        }
      } else {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
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

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }
}
