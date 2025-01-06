import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:spend_wise/_common/_widget/maxCustomCard.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/budget/budget_create/v_budget_create.dart';
import 'package:spend_wise/modules/budget/budget_details/v_budget_detail.dart';
import 'package:spend_wise/modules/budget/c_budget.dart';
import 'package:get/get.dart';

class BudgetPage extends StatelessWidget {
  const BudgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    BudgetController controller = Get.put(BudgetController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.background,
            leadingWidth: 130,
            // toolbarHeight: 100,
            leading: Card(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.arrow_left_2,
                      size: 22,
                      color: theme.background,
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: controller.viewMonth,
                    builder: (context, value, child) {
                      return Text(
                        DateFormat('MMM').format(value),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Iconsax.arrow_right_3,
                      size: 22,
                      color: theme.background,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => const BudgetCreatePage())?.whenComplete(() {
                    controller.onInit();
                  });
                },
                icon: const Icon(
                  Iconsax.add_square,
                  size: 28,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 13, right: 13),
              child: RefreshIndicator(
                child: ValueListenableBuilder(
                  valueListenable: controller.xFetching,
                  builder: (context, xFetching, child) {
                    if (xFetching) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ValueListenableBuilder(
                        valueListenable: controller.budgetList,
                        builder: (context, budgetList, child) {
                          if (budgetList.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "You don’t have a budget.\nLet’s make one so you in control.",
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(15),
                                  IconButton(
                                    onPressed: () {
                                      controller.fetchBudgetList();
                                    },
                                    icon: Icon(
                                      Icons.refresh,
                                      color: theme.background,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: budgetList.length,
                              itemBuilder: (context, index) {
                                final each = budgetList[index];
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(
                                      () => BudgetDetailPage(
                                        each: each,
                                      ),
                                    );
                                  },
                                  child: MaxCustonCard(
                                    tag: each.categoryModel.categoryName,
                                    xExceed: each.budgetAmount < each.budgetUsed
                                        ? true
                                        : false,
                                    totoal: each.budgetAmount,
                                    used: each.budgetUsed,
                                    remaining: each.remainingAmount,
                                  ),
                                );
                              },
                            );
                          }
                        },
                      );
                    }
                  },
                ),
                onRefresh: () {
                  return controller.fetchBudgetList();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
