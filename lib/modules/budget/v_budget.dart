import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
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
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(
                Iconsax.arrow_left_2,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            title: ValueListenableBuilder(
              valueListenable: controller.titleMonth,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.arrow_right_3,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Expanded(
                    child: Placeholder(),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 50),
                      child: const Text(
                        "Create a budget",
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
            ),
          ),
        );
      },
    );
  }
}
