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
    FlSpot(1, 1),
    FlSpot(2, 1),
    FlSpot(3, 4),
    FlSpot(4, 5),
    FlSpot(5, 2),
    FlSpot(6, 3),
  ];
  List<FlSpot> data2 = const [
    FlSpot(0, 0),
    FlSpot(1, 4),
    FlSpot(2, 3),
    FlSpot(3, 5),
    FlSpot(4, 6),
    FlSpot(5, 2),
    FlSpot(6, 5),
    FlSpot(7, 2),
    FlSpot(8, 7),
    FlSpot(9, 5),
    FlSpot(10, 3),
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
    }
  }
}
