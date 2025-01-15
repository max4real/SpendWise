import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

import '../../_servies/network_services/api_endpoint.dart';
import '../../models/m_me_model.dart';
import '../../models/m_transaction_list_model.dart';

class HomePageController extends GetxController {
  int page = 1;
  int size = 4;
  DataController dataController = Get.find();
  DateTime today = DateTime.now();

  ValueNotifier<bool> xFetching = ValueNotifier(true);
  ValueNotifier<List<TransactionListModel>> transactionList = ValueNotifier([]);

  ValueNotifier<int> tabIndex = ValueNotifier(0);

  ValueNotifier<List<FlSpot>> chartDataList = ValueNotifier([]);
  String chartDataKey = 'weekly';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {
    fetchChartData(key: chartDataKey);
    fetchTransactionList();
  }

  Future<void> onRefresh() async {
    fetchChartData(key: chartDataKey);
    fetchTransactionList();
    fetchMeAPI(dataController.apiToken);
  }

  void chartTabOnChnage(int index) {
    if (index == 0) {
      chartDataKey = "weekly";
      fetchChartData(key: chartDataKey);
    } else if (index == 1) {
      chartDataKey = "monthly";
      fetchChartData(key: chartDataKey);
    } else if (index == 2) {
      chartDataKey = "yearly";
      fetchChartData(key: chartDataKey);
    }
  }

  Future<void> reloadChart() async {
    fetchChartData(key: chartDataKey);
  }

  Future<void> fetchChartData({required String key}) async {
    print('fetching chart data');
    String url =
        "${ApiEndpoint.baseUrl}${ApiEndpoint.transactionExpenseUsage}?timeFrame=$key";

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
        Iterable iterable = response.body["breakdown"];

        List<FlSpot> temp = [];

        for (int i = 0; i < iterable.length; i++) {
          final item = iterable.elementAt(i);
          double x = i.toDouble();
          double y = double.tryParse(item['total'].toString()) ?? -1;
          temp.add(FlSpot(x, y));
        }

        chartDataList.value.clear();
        chartDataList.value = temp;
      } else {
        print(response.body);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> fetchTransactionList() async {
    print('fetching Transaction');
    String url =
        "${ApiEndpoint.baseUrl}${ApiEndpoint.transaction}?page=$page&limit=$size";

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
      } else {
        xFetching.value = false;
        print(response.body);
        maxSuccessDialog(
            response.body['_metadata']['message'].toString(), false);
      }
    } catch (e) {}
  }

  Future<void> fetchMeAPI(String? token) async {
    String meUrl = ApiEndpoint.baseUrl + ApiEndpoint.meAPI;
    GetConnect client = GetConnect(timeout: const Duration(seconds: 20));
    final meResponse = await client.get(
      meUrl,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (meResponse.isOk) {
      print(meResponse.body);

      MeModel rawData = MeModel.fromAPI(data: meResponse.body['profile']);
      dataController.meModelNotifier.value = rawData;
    } else {
      print(meResponse.body);
    }
  }
}
