import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePageController extends GetxController {
  // TextEditingController txtBalance = TextEditingController(text: '153000');
  ValueNotifier<double> totalBalance = ValueNotifier(153000);
  ValueNotifier<double> totalIncome = ValueNotifier(120000);
  ValueNotifier<double> totalOutcome = ValueNotifier(75000);

  ValueNotifier<int> tabIndex = ValueNotifier(0);

  ValueNotifier<List<FlSpot>> chartDataList = ValueNotifier([]);

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
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    chartDataList.value = [...data1];
  }

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
}
