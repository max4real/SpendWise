import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/models/m_account_model.dart';
import 'package:spend_wise/models/m_transaction_list_model.dart';

import '../../../_common/data/data_controller.dart';
import '../../../_servies/network_services/api_endpoint.dart';

class AccountDetailController extends GetxController {
  String accId = '';
  DataController dataController = Get.find();
  ValueNotifier<bool> xFetching = ValueNotifier(false);
  ValueNotifier<String> accName = ValueNotifier('');
  ValueNotifier<List<TransactionListModel>> transactionList = ValueNotifier([]);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void initLoad(AccountModel accountModel) {
    accName.value = accountModel.accName;
    accId = accountModel.accId;
    fetchTransaction();
  }

  Future<void> fetchTransaction() async {
    print("acc id - " + accId);
    String url = '${ApiEndpoint.baseUrl}${ApiEndpoint.account}/$accId';

    GetConnect client = GetConnect(timeout: const Duration(minutes: 1));
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
        print(response.body['message'].toString());

        Iterable iterable = response.body['transaction'] ?? [];
        List<TransactionListModel> temp = [];

        for (var element in iterable) {
          TransactionListModel rawData =
              TransactionListModel.forList(data: element);
          temp.add(rawData);
        }
        transactionList.value = [...temp];
      } else {
        print(response.body['message'].toString());
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }

  Future<void> deleteAccount() async {
    String url = '${ApiEndpoint.baseUrl}${ApiEndpoint.account}/$accId';

    GetConnect client = GetConnect(timeout: const Duration(seconds: 10));
    try {
      Get.dialog(const Center(child: CircularProgressIndicator()));

      final response = await client.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();
      if (response.isOk) {
        print(response.body['message'].toString());

        Get.back();
      } else {
        print(response.body['message'].toString());
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }
}
