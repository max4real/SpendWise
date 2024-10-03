import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  ValueNotifier<int> badgeCount = ValueNotifier(0);
  ValueNotifier<String> periodFilter = ValueNotifier('Month');
  ValueNotifier<bool> filterIncome = ValueNotifier(false);
  ValueNotifier<bool> filterExpense = ValueNotifier(false);
  ValueNotifier<bool> filterTransfer = ValueNotifier(false);

  ValueNotifier<bool> sortHigh = ValueNotifier(false);
  ValueNotifier<bool> sortLow = ValueNotifier(false);
  ValueNotifier<bool> sortNew = ValueNotifier(false);
  ValueNotifier<bool> sortOld = ValueNotifier(false);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void controlFilter(String name, bool value) {
    if (name == 'Income') {
      filterIncome.value = !value;
      filterExpense.value = false;
      filterTransfer.value = false;
    } else if (name == 'Expense') {
      filterIncome.value = false;
      filterExpense.value = !value;
      filterTransfer.value = false;
    } else if (name == 'Transfer') {
      filterIncome.value = false;
      filterExpense.value = false;
      filterTransfer.value = !value;
    }
  }

  void controlSort(String name, bool value) {
    if (name == 'Highest') {
      sortHigh.value = !value;
      sortLow.value = false;
      sortNew.value = false;
      sortOld.value = false;
    } else if (name == 'Lowest') {
      sortHigh.value = false;
      sortLow.value = !value;
      sortNew.value = false;
      sortOld.value = false;
    } else if (name == 'Newest') {
      sortHigh.value = false;
      sortLow.value = false;
      sortNew.value = !value;
      sortOld.value = false;
    } else if (name == 'Oldest') {
      sortHigh.value = false;
      sortLow.value = false;
      sortNew.value = false;
      sortOld.value = !value;
    }
  }

  void resetFilters() {
    filterIncome.value = false;
    filterExpense.value = false;
    filterTransfer.value = false;
    sortHigh.value = false;
    sortLow.value = false;
    sortNew.value = false;
    sortOld.value = false;
  }

  void applyBadgeCount() {
    int count = 0;
    if (filterIncome.value || filterExpense.value || filterTransfer.value) {
      count++;
    }

    if (sortHigh.value || sortLow.value || sortNew.value || sortOld.value) {
      count++;
    }
    badgeCount.value = count;
  }

  void applyFilters() {
    Get.back();
  }
}
