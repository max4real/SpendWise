import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/modules/account_setup/v_setup.dart';

import '../../../_common/data/data_controller.dart';
import '../../../models/m_account_model.dart';
import '../../../models/m_me_model.dart';
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
    String url = ApiEndpoint.baseUrl + ApiEndpoint.authLogin;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.post(url, {
        "email": txtEmail.text,
        "password": txtPassword.text,
      });

      Get.back();
      if (response.isOk) {
        String token = response.body["access_token"].toString();
        dataController.apiToken = token;
        saveToken(token);
        saveEmail(txtEmail.text);
        print('Token - ' + token);

        String meUrl = ApiEndpoint.baseUrl + ApiEndpoint.meAPI;
        final meResponse = await client.get(
          meUrl,
          headers: {
            'Authorization': 'Bearer ${dataController.apiToken}',
            'Content-Type': 'application/json',
          },
        );

        if (meResponse.isOk) {
          print(meResponse.body['profile']['name']);

          MeModel rawData = MeModel.fromAPI(data: meResponse.body['profile']);
          dataController.meModelNotifier = ValueNotifier(rawData);

          if (await isAccountListEmpty()) {
            Get.offAll(() => const SetupGateway());
          } else {
            Get.offAll(() => const MainPage());
          }
        } else {
          maxSuccessDialog(
              meResponse.body['message'].toString(), false);
        }
      } else {
        maxSuccessDialog(
            response.body['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<bool> isAccountListEmpty() async {
    print('Fetching account list');
    String url = ApiEndpoint.baseUrl + ApiEndpoint.account;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );
      Get.back();
      if (response.isOk) {
        List<AccountModel> temp = [];

        Iterable iterable = response.body ?? [];

        for (var element in iterable) {
          AccountModel rawData = AccountModel.fromAPI(data: element);
          temp.add(rawData);
        }
        if (temp.isEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        maxSuccessDialog(
            response.body['message'].toString(), false);
      }
    } catch (e) {}
    return false;
  }

  // Future<void> saveAccountSetupState(String state) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('setup_state', state);
  // }

  // Future<String> getAccountSetupState() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? state = prefs.getString('setup_state');

  //   if (state != null) {
  //     return state;
  //   } else {
  //     return '';
  //   }
  // }

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
