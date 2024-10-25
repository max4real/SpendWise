import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/modules/transaction/c_transaction_page.dart';

import '../../../_servies/theme_services/w_custon_theme_builder.dart';

// ignore: must_be_immutable
class DatatimeWidget extends StatelessWidget {
  DatatimeWidget({super.key});
  TransactionController controller = Get.find();
  DataController dataController = Get.find();
  final int yearCount = 10;

  @override
  Widget build(BuildContext context) {
    FixedExtentScrollController monthController = FixedExtentScrollController(
        initialItem: controller.startDate.value.month - 1);

    FixedExtentScrollController yearController = FixedExtentScrollController(
        initialItem: controller.startDate.value.year);

    int selectedMonth = controller.startDate.value.month;
    int selectedYear = controller.startDate.value.year;
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Date Time",
                style: TextStyle(color: theme.text1, fontSize: 18),
              ),
              Container(
                height: Get.height * 0.25,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: monthController,
                        magnification: 1.35,
                        itemExtent: 30,
                        onSelectedItemChanged: (value) {
                          selectedMonth = value + 1;
                          // print(selectedMonth);
                        },
                        children: List.generate(12, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: FittedBox(
                              child: Text(
                                dataController.monthsMap[index + 1].toString(),
                                style: TextStyle(color: theme.text1),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: yearController,
                        magnification: 1.35,
                        itemExtent: 30,
                        onSelectedItemChanged: (value) {
                          // print(
                          //     "Selected Year ${DateTime.now().year - (10 - value) + 1}");
                          selectedYear = DateTime.now().year - (10 - value) + 1;
                        },
                        children: List.generate(yearCount, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: FittedBox(
                              child: Text(
                                (DateTime.now().year - index).toString(),
                                style: TextStyle(color: theme.text1),
                              ),
                            ),
                          );
                        }).reversed.toList(),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.changeMonth(
                      month: selectedMonth, year: selectedYear);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.background,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 90),
                  child: const Text(
                    "Apply",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
