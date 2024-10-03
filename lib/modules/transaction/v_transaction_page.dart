import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/_widget/maxMultiButton.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/transaction/c_transaction_page.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../../_common/_widget/maxListTile.dart';

class TransactionPage extends StatelessWidget {
  const TransactionPage({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionController controller = Get.put(TransactionController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            leadingWidth: 100,
            leading: Center(
              child: GestureDetector(
                onTap: () {
                  maxSnackBar(context, 'Period Filter');
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.arrow_down_1,
                          size: 20,
                          color: theme.background,
                        ),
                        const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: controller.periodFilter,
                          builder: (context, periodFilter, child) {
                            return Text(periodFilter);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              ValueListenableBuilder(
                valueListenable: controller.badgeCount,
                builder: (context, value, child) {
                  return IconButton(
                    onPressed: () {
                      // maxSnackBar(context, 'Filter');
                      showFilterSheet();
                    },
                    icon: value == 0
                        ? const Icon(
                            Iconsax.filter,
                            size: 27,
                          )
                        : Badge.count(
                            backgroundColor: theme.background,
                            padding: const EdgeInsets.all(1),
                            count: value,
                            child: const Icon(
                              Iconsax.filter,
                              size: 27,
                            ),
                          ),
                  );
                },
              ),
              const SizedBox(width: 5)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 8,
            ),
            child: Column(
              children: [
                //financial report
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0XFFEEE5FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'See your financial report',
                          style: TextStyle(color: theme.background),
                        ),
                        Icon(
                          Iconsax.arrow_right_3,
                          color: theme.background,
                        )
                      ],
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return MaxListTile(
                        title: 'Shopping $index',
                        subtitle: 'This week car gas',
                        amount: 54000,
                        time: DateTime.now(),
                        transaction: index % 2 == 0 ? true : false,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showFilterSheet() {
    TransactionController controller = Get.find();
    Get.bottomSheet(
      backgroundColor: Colors.white,
      isDismissible: false,
      enableDrag: false,
      MaxThemeBuilder(
        builder: (context, theme, themeController) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //reset row
                Row(
                  children: [
                    const Text(
                      'Filter Transaction',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0XFF0D0E0F),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        controller.resetFilters();
                        controller.applyBadgeCount();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0XFFEEE5FF),
                            borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        child: Text(
                          'Reset',
                          style: TextStyle(color: theme.background),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                //Filter By
                const Text(
                  'Filter By',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0XFF0D0E0F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.filterIncome,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlFilter('Income', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Income',
                            value: value,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.filterExpense,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlFilter('Expense', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Expense',
                            value: value,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.filterTransfer,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlFilter('Transfer', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Transfer',
                            value: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(15),
                //Sort By
                const Text(
                  'Sort By',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0XFF0D0E0F),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Gap(5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.sortHigh,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlSort('Highest', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Highest',
                            value: value,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.sortLow,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlSort('Lowest', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Lowest',
                            value: value,
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: controller.sortNew,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlSort('Newest', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Newest',
                            value: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: controller.sortOld,
                      builder: (context, value, child) {
                        return GestureDetector(
                          onTap: () {
                            controller.controlSort('Oldest', value);
                            controller.applyBadgeCount();
                          },
                          child: MaxMultiButton(
                            text: 'Oldest',
                            value: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const Gap(20),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      controller.applyFilters();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 110),
                      child: const Text(
                        "Apply",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
