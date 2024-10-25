import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_servies/network_services/api_endpoint.dart';
import 'package:spend_wise/models/m_transaction_list_model.dart';

import '../../_common/data/data_controller.dart';

class TransactionController extends GetxController {
  DataController dataController = Get.find();
  int page = 1;
  int size = 10;
  ValueNotifier<bool> moreLoading = ValueNotifier(false);
  ValueNotifier<bool> xFetching = ValueNotifier(true);

  ValueNotifier<List<TransactionListModel>> transactionList = ValueNotifier([]);

  ValueNotifier<int> badgeCount = ValueNotifier(0);

  ValueNotifier<DateTime> startDate =
      ValueNotifier(DateTime(DateTime.now().year, DateTime.now().month, 1));

  ValueNotifier<DateTime> endDate = ValueNotifier(
      DateTime(DateTime.now().year, DateTime.now().month + 1 - 1, 0)
          .subtract(const Duration(days: 1)));

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
    initLoad();
  }

  void initLoad() {
    fetchTransactionList();
  }

  void loadMore() {
    //try removing condition
    moreLoading.value = true;
    if (transactionList.value.length == page * size) {
      page = page + 1;
      fetchTransactionList();
    } else {
      moreLoading.value = false;
    }
  }

  void changeMonth({required int month, required int year}) {
    startDate.value = DateTime(year, month, 1);
    endDate.value =
        DateTime(year, month + 1, 1).subtract(const Duration(days: 1));
    print(startDate.value);
    print(endDate.value);
    print(month);
    print(year);
    // toIso8601String
    Get.back();

    //call fetching method
  }

  void applyFilters() {
    Get.back();
  }

  Future<void> fetchTransactionList() async {
    print('fetching Transaction');
    String url =
        "${ApiEndpoint.baseUrl2}${ApiEndpoint.transaction}?page=$page&size=$size";

    GetConnect client = GetConnect(timeout: const Duration(seconds: 30));

    try {
      final response = await client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${dataController.apiToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.isOk) {
        print(response.body['_metadata']['message']);
        List<TransactionListModel> temp =
            page == 1 ? [] : [...transactionList.value];

        Iterable iterable = response.body['_data']['result'] ?? [];

        for (var element in iterable) {
          TransactionListModel rawData =
              TransactionListModel.forListWithImage(data: element);
          temp.add(rawData);
        }
        transactionList.value = temp;
        xFetching.value = false;
        moreLoading.value = false;
      } else {
        xFetching.value = false;
        print(response.body['_metadata']['message']);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
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
}
