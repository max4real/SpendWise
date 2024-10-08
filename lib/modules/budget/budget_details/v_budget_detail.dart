import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/_widget/maxButton.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/budget/budget_edit/v_budget_edit.dart';

import '../../../_common/constants/app_svg.dart';
import '../../../_common/data/data_controller.dart';

class BudgetDetailPage extends StatelessWidget {
  const BudgetDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: theme.background,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.black,
                size: 30,
              ),
            ),
            title: const Text(
              'Detail Budget',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.black,
                  size: 25,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                Expanded(
                    child: SizedBox.expand(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 200,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              children: [
                                SvgPicture.string(
                                  AppSvgs.svgGreenDot,
                                  width: 20,
                                  height: 20,
                                ),
                                const Gap(10),
                                const Text(
                                  "ShoppingABCDEF",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5D5C5C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      const Text(
                        'Remaining',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0XFF0D0E0F),
                            fontWeight: FontWeight.w600),
                      ),
                      // const Gap(20),
                      const Text(
                        '15,000 Ks',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0XFF0D0E0F),
                            fontWeight: FontWeight.w400),
                      ),
                      const Gap(20),
                      SizedBox(
                        height: 15,
                        width: double.infinity,
                        child: LinearProgressIndicator(
                          value: 0.5,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.grey[300],
                          valueColor:
                              AlwaysStoppedAnimation<Color>(theme.background),
                        ),
                      ),
                      const Gap(20),
                      Text(
                        'You have spend ${formatNumber(40000)} of ${formatNumber(100000)} Ks.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Color(0XFF0D0E0F),
                        ),
                      ),
                      const Gap(20),
                      Visibility(
                        visible: true,
                        child: SvgPicture.string(
                          AppSvgs.svgExceedMessage,
                          width: 200,
                        ),
                      )
                    ],
                  ),
                )),
                const Gap(20),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const BudgetEditPage());
                  },
                  child: MaxButton(title: 'Edit'),
                ),
                const Gap(20),
              ],
            ),
          ),
        );
      },
    );
  }
}
