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

  ValueNotifier<bool> xFetching = ValueNotifier(true);
  ValueNotifier<List<TransactionListModel>> transactionList = ValueNotifier([]);

  ValueNotifier<int> tabIndex = ValueNotifier(0);

  ValueNotifier<List<FlSpot>> chartDataList = ValueNotifier([]);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chartDataList.value = [...data1];
    initLoad();
  }

  void initLoad() {
    fetchTransactionList();
  }

  Future<void> onRefresh() async {
    fetchTransactionList();
    fetchMeAPI(dataController.apiToken);
  }

  List<FlSpot> data1 = const [
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 40000),
    FlSpot(4, 0),
    FlSpot(5, 2000),
    FlSpot(6, 0),
    FlSpot(7, 0),
    FlSpot(8, 0),
    FlSpot(9, 0),
    FlSpot(10, 1500),
    FlSpot(11, 0),
    FlSpot(12, 0),
    FlSpot(13, 0),
    FlSpot(14, 0),
    FlSpot(15, 0),
    FlSpot(16, 3500),
    FlSpot(17, 0),
    FlSpot(18, 4500),
    FlSpot(19, 0),
    FlSpot(20, 0),
    FlSpot(21, 0),
    FlSpot(22, 0),
    FlSpot(23, 0),
    FlSpot(24, 0),
  ];
  List<FlSpot> data2 = const [
    FlSpot(3, 40000),
    FlSpot(5, 2000),
    FlSpot(10, 1500),
    FlSpot(13, 25000),
    FlSpot(16, 3500),
    FlSpot(18, 4500),
  ];
  List<FlSpot> data3 = const [
    FlSpot(0, 1000),
    FlSpot(3, 5000),
    FlSpot(4, 3000),
    FlSpot(8, 13000),
    FlSpot(10, 8000),
    FlSpot(12, 9500),
    FlSpot(14, 400),
    FlSpot(16, 0),
    FlSpot(18, 500),
    FlSpot(20, 0),
    FlSpot(22, 3500),
    FlSpot(24, 0),
  ];

  void chartTabOnChnage(int index) {
    if (index == 0) {
      chartDataList.value.clear();
      chartDataList.value = [...data1];
    } else if (index == 1) {
      chartDataList.value.clear();
      chartDataList.value = [...data2];
    } else if (index == 2) {
      chartDataList.value.clear();
      chartDataList.value = [...data3];
    }
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
