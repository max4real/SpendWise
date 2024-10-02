import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  // TextEditingController txtBalance = TextEditingController(text: '153000');
  ValueNotifier<double> totalBalance = ValueNotifier(153000);
  ValueNotifier<double> totalIncome = ValueNotifier(120000);
  ValueNotifier<double> totalOutcome = ValueNotifier(75000);

  ValueNotifier<int> tabIndex = ValueNotifier(0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
