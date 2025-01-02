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

  String activeFilter = "";
  String activeSort = "";

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    fetchTransactionList();
  }

  Future<void> reloadAll() async {
    page = 1;
    size = 10;
    fetchTransactionList();
  }

  void loadMore() {
    if (filterIncome.value ||
        filterExpense.value ||
        filterTransfer.value ||
        sortHigh.value ||
        sortLow.value ||
        sortNew.value ||
        sortOld.value) {
      moreLoading.value = true;
      if (transactionList.value.length == page * size) {
        page = page + 1;
        fetchTransactionList(
          xWithFilter: true,
          filterBy: activeFilter,
          sortBy: activeSort,
        );
      } else {
        moreLoading.value = false;
      }
    } else {
      moreLoading.value = true;
      if (transactionList.value.length == page * size) {
        page = page + 1;
        fetchTransactionList();
      } else {
        moreLoading.value = false;
      }
    }
  }

  void onChangeMonth({required int month, required int year}) {
    startDate.value = DateTime(year, month, 1);
    endDate.value =
        DateTime(year, month + 1, 1).subtract(const Duration(days: 1));

    print(startDate.value);
    print(endDate.value);

    print(month);
    print(year);

    Get.back();

    //call fetching method
  }

  void applyFilters() {
    activeFilter = "";
    activeSort = "";
    if (filterIncome.value) activeFilter = ("INCOME");
    if (filterExpense.value) activeFilter = ("EXPENSE");
    if (filterTransfer.value) activeFilter = ("TRANSFER");

    if (sortHigh.value) activeSort = ("HIGHEST");
    if (sortLow.value) activeSort = ("LOWEST");
    if (sortNew.value) activeSort = ("NEWEST");
    if (sortOld.value) activeSort = ("OLDEST");

    if (activeFilter != "" || activeSort != "") {
      print("Active Filter - $activeFilter");
      print("Active Sort - $activeSort");

      page = 1;
      size = 10;
      fetchTransactionList(
        xWithFilter: true,
        filterBy: activeFilter,
        sortBy: activeSort,
      );
    }

    Get.back();
  }

  Future<void> fetchTransactionList({
    bool xWithFilter = false,
    String? filterBy,
    String? sortBy,
  }) async {
    print('Fetching Transaction');
    String url =
        "${ApiEndpoint.baseUrl}${ApiEndpoint.transaction}?page=$page&limit=$size";

    if (xWithFilter) {
      url =
          "${ApiEndpoint.baseUrl}${ApiEndpoint.transaction}?page=$page&limit=$size${filterBy == "" ? "" : "&filterBy=$filterBy"}${sortBy == "" ? "" : "&sortBy=$sortBy"}";
    }

    print(url);

    if (!moreLoading.value) {
      xFetching.value = true;
    }
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
        print(response.body);
        List<TransactionListModel> temp =
            page == 1 ? [] : [...transactionList.value];

        Iterable iterable = response.body["transactions"] ?? [];

        for (var element in iterable) {
          TransactionListModel rawData =
              TransactionListModel.forListWithAllField(data: element);
          temp.add(rawData);
        }
        transactionList.value = temp;
        xFetching.value = false;
        moreLoading.value = false;
      } else {
        xFetching.value = false;
        print(response.body);
        maxSuccessDialog(response.body['message'].toString(), false);
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

  Future<void> resetFilters() async {
    filterIncome.value = false;
    filterExpense.value = false;
    filterTransfer.value = false;
    sortHigh.value = false;
    sortLow.value = false;
    sortNew.value = false;
    sortOld.value = false;

    applyBadgeCount();
    reloadAll();

    Get.back();
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
