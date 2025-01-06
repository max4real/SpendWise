import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../_common/data/data_controller.dart';
import '../../_servies/network_services/api_endpoint.dart';
import '../../models/m_budget_model.dart';

class BudgetController extends GetxController {
  DataController dataController = Get.find();
  ValueNotifier<DateTime> viewMonth = ValueNotifier(DateTime.now());

  ValueNotifier<List<BudgetModel>> budgetList = ValueNotifier([]);
  ValueNotifier<bool> xFetching = ValueNotifier(true);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    fetchBudgetList();
  }

  Future<void> fetchBudgetList() async {
    print('fetching Budget List');
    String url = "${ApiEndpoint.baseUrl}${ApiEndpoint.budget}";

    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    try {
      xFetching.value = true;
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isOk) {
        print(response.body);
        List<BudgetModel> temp = [];

        Iterable iterable = response.body ?? [];

        for (var element in iterable) {
          BudgetModel rawData = BudgetModel.fromAPI(data: element);
          temp.add(rawData);
        }
        budgetList.value = temp;
        xFetching.value = false;
      } else {
        xFetching.value = false;
        print(response.body);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }
}
