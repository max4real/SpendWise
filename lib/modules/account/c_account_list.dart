import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/models/m_account_model.dart';

class AccountListController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<List<AccountModel>> accountList = ValueNotifier([]);
  ValueNotifier<int> totalBalance = ValueNotifier(0);
  ValueNotifier<bool> xFetching = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    totalBalance.value = 0;
    fetchAccountList();
  }

  Future<void> fetchAccountList() async {
    String url = ApiEndpoint.baseUrl2 + ApiEndpoint.account;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));

    try {
      xFetching.value = true;
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );
      xFetching.value = false;
      if (response.isOk) {
        // maxSuccessDialog(
        //     response.body['_metadata']['message'].toString(), true);
        List<AccountModel> temp = [];

        Iterable iterable = response.body['_data'] ?? [];

        for (var element in iterable) {
          AccountModel rawData = AccountModel.fromAPI(data: element);
          temp.add(rawData);
          totalBalance.value = totalBalance.value + rawData.accBalance;
        }
        accountList.value = [...temp];
      } else {
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }
}
