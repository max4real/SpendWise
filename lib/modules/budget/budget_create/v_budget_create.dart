import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/modules/budget/budget_create/c_budget_create.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../_common/constants/app_svg.dart';
import '../../../_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

class BudgetCreatePage extends StatelessWidget {
  const BudgetCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    BudgetCreateController controller = Get.put(BudgetCreateController());
    DataController dataController = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.background,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
                size: 30,
              ),
            ),
            title: const Text(
              'Create Budget',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: Get.width,
                  height: 250,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How Much?',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        //Amount Text Field row
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: controller.txtAmount,
                                keyboardType: TextInputType.number,
                                onTapOutside: (event) {
                                  dismissKeyboard();
                                },
                                cursorColor: theme.background,
                                cursorHeight: 30,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '0 Ks',
                                  hintStyle: TextStyle(
                                    fontSize: 30,
                                    color: Color.fromARGB(255, 235, 234, 234),
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'MMK',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  // height: Get.height-250,
                  height: MediaQuery.of(context).size.height - 330,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: controller.selectedCategory,
                          builder: (context, value, child) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: value,
                                  elevation: 8,
                                  borderRadius: BorderRadius.circular(20),
                                  menuWidth: Get.width * 0.6,
                                  menuMaxHeight: 300,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  hint: const Text(
                                    'Category',
                                    style: TextStyle(
                                      color: Color(0XFF91919F),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(
                                    Iconsax.arrow_right_3,
                                    color: theme.background,
                                  ),
                                  items: dataController.categoryTags
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            children: [
                                              SvgPicture.string(
                                                  AppSvgs.svgGreenDot),
                                              const Gap(10),
                                              Text(
                                                value,
                                                style: const TextStyle(
                                                  color: Color(0xFF5D5C5C),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) {
                                    controller.selectedCategory.value =
                                        newValue;
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const Gap(25),
                        Row(
                          children: [
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Receive Alert',
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  'Receive alert when it reaches some point.',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            ValueListenableBuilder(
                              valueListenable: controller.xSwitched,
                              builder: (context, value, child) {
                                return Switch(
                                  value: value,
                                  onChanged: (value) {
                                    controller.xSwitched.value = value;
                                  },
                                  activeColor: theme.background,
                                  // inactiveThumbColor: theme.background2,
                                  inactiveTrackColor: theme.background2,
                                  trackOutlineWidth: MaterialStateProperty
                                      .resolveWith<double?>(
                                    (Set<MaterialState> states) {
                                      return 0; // Use the default width.
                                    },
                                  ),
                                  trackOutlineColor:
                                      MaterialStateProperty.resolveWith<Color?>(
                                          (Set<MaterialState> states) {
                                    return theme
                                        .background2; // Use the default color.
                                  }),
                                );
                              },
                            )
                          ],
                        ),
                        const Gap(20),
                        ValueListenableBuilder(
                          valueListenable: controller.xSwitched,
                          builder: (context, value, child) {
                            return Visibility(
                              visible: value,
                              child: ValueListenableBuilder(
                                valueListenable: controller.progressIndi,
                                builder: (context, progress, child) {
                                  return Row(
                                    children: [
                                      Expanded(
                                        child: SfSlider(
                                          min: 0.00,
                                          max: 1,
                                          value: progress,
                                          showTicks: false,
                                          showLabels: false,
                                          enableTooltip: false,
                                          // numberFormat: NumberFormat('#%'),
                                          onChanged: (dynamic value) {
                                            controller.progressIndi.value =
                                                value;
                                          },
                                        ),
                                      ),
                                      Text('${(progress * 100).toInt()}%'),
                                      const Gap(10)
                                    ],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        const Gap(25),
                        GestureDetector(
                          onTap: () {
                            controller.printData();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.background,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 110),
                            child: const Text(
                              "Continue",
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
