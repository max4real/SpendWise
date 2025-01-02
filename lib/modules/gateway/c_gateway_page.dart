import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/models/m_me_model.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/v_login_gateway.dart';
import 'package:spend_wise/modules/main_page/v_main_page.dart';

import '../../_servies/network_services/api_endpoint.dart';

class GatewayController extends GetxController {
  DataController dataController = Get.find();
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
  }

  Future<void> initLoad() async {
    await getEmail();
    await Future.delayed(const Duration(milliseconds: 500));
    if (dataController.apiToken != '') {
      if (await fetchMeAPI(dataController.apiToken)) {
        print('Token - ${dataController.apiToken}');
        print('1');
        Get.offAll(() => const MainPage());
      } else {
        print('Token - ${dataController.apiToken}');
        print('2');
        Get.offAll(() => const LoginPage());
      }
    } else {
      if (email_ == '') {
        print('Token - ${dataController.apiToken}');
        print('3');
        Get.offAll(() => const LoginGatewayPage());
      } else {
        print('Token - ${dataController.apiToken}');
        print('4');
        Get.off(() => const LoginPage());
      }
    }
  }

  Future<bool> fetchMeAPI(String? token) async {
    String meUrl = ApiEndpoint.baseUrl + ApiEndpoint.meAPI;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    final meResponse = await client.get(
      meUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (meResponse.isOk) {
      print(meResponse.body);
      print(meResponse.body['profile']['name']);

      MeModel rawData = MeModel.fromAPI(data: meResponse.body['profile']);
      dataController.meModelNotifier = ValueNotifier(rawData);

      return true;
    } else {
      print(meResponse.body);

      return false;
    }
  }

  String email_ = '';
  Future<void> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      email_ = email;
    } else {
      email_ = "";
    }
  }
}
