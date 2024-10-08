import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetEditController extends GetxController {
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
    txtAmount.text = "100000";
    selectedCategory.value = "Food";
    xSwitched.value = true;
    progressIndi.value = 0.6;
  }
}
