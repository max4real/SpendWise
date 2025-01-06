import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/modules/budget/c_budget.dart';

import '../../../_servies/network_services/api_endpoint.dart';

class BudgetCreateController extends GetxController {
  DataController dataController = Get.find();

  TextEditingController txtAmount = TextEditingController();
  ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  ValueNotifier<bool> xSwitched = ValueNotifier(false);
  ValueNotifier<double> progressIndi = ValueNotifier(0.8);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    dataController.fetchCategoryList();
  }

  void checkAllField() {
    if (txtAmount.text.isEmpty) {
      return maxMessageDialog('Please Enter Amount.');
    }
    if (selectedCategory.value == null) {
      return maxMessageDialog('Please Select Category.');
    }
    if (xSwitched.value) {
      if (progressIndi.value == 0) {
        return maxMessageDialog('Can\'t be at 0%.');
      }
    }
    print(txtAmount.text);
    print(getCategoryID(selectedCategory.value!));

    createBudget();
  }

  Future<void> createBudget() async {
    print('------------------------------------------------------------------');
    print('------------------------- Create Budget ------------------------');

    Get.dialog(const Center(child: CircularProgressIndicator()));

    String url = ApiEndpoint.baseUrl + ApiEndpoint.budget;
    GetConnect client = GetConnect(timeout: const Duration(minutes: 1));
    try {
      final response = await client.post(
        url,
        {
          "amount": int.tryParse(txtAmount.text) ?? -1,
          "categoryId": getCategoryID(selectedCategory.value!).toString(),
          "notification": bool.tryParse(xSwitched.value.toString()) ?? false,
          if (xSwitched.value) "percentage": (progressIndi.value * 100).toInt()
        },
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      Get.back();

      if (response.isOk) {
        print(response.body);
        maxSuccessDialog2(
          "Successfully Created",
          true,
          () {
            BudgetController budgetController = Get.find();
            budgetController.fetchBudgetList();
            clearAllField();
            Get.back();
          },
          'Continue',
        );
      } else {
        print("Not OK");
        print(response.body);
        maxSuccessDialog(response.body['message'].toString(), false);
      }
    } catch (e) {}
  }

  void clearAllField() {
    txtAmount.text = '';
    selectedCategory.value = null;
    xSwitched.value = false;
    progressIndi.value = 0.8;
  }

  String getCategoryID(String categoryName) {
    for (var element in dataController.categoryList.value) {
      if (element.categoryName == categoryName) {
        return element.categoryID;
      }
    }
    return '';
  }
}
