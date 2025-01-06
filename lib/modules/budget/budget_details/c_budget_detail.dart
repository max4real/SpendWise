import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/modules/budget/c_budget.dart';

import '../../../_servies/network_services/api_endpoint.dart';

class BudgetDetailController extends GetxController {
  DataController dataController = Get.find();

  Future<void> deleteBudget(String budgetID) async {
    String url = '${ApiEndpoint.baseUrl}${ApiEndpoint.budget}/$budgetID';

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
        Get.back();
        Get.back();
        BudgetController budgetController = Get.find();
        budgetController.fetchBudgetList();
        maxSuccessDialog('Budget has been successfully removed', true);
      } else {
        print(response.body['message'].toString());
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e1) {}
  }
}
