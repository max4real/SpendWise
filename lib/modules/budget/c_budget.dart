import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  ValueNotifier<DateTime> viewMonth = ValueNotifier(DateTime.now());
  ValueNotifier<bool> budgetDataList= ValueNotifier(false);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
