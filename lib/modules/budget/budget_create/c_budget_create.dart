import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetCreateController extends GetxController {
  TextEditingController txtAmount = TextEditingController();
  ValueNotifier<String?> selectedCategory = ValueNotifier(null);
  ValueNotifier<bool> xSwitched = ValueNotifier(false);
  ValueNotifier<double> progressIndi = ValueNotifier(0.8);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void printData() {
    print((progressIndi.value * 100).toInt());
  }
}
