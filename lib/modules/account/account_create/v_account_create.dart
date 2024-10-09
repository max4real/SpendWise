import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/_widget/maxMultiButton_2.dart';
import 'package:spend_wise/modules/account/account_create/c_account_create.dart';

import '../../../_common/constants/app_svg.dart';
import '../../../_common/data/data_controller.dart';
import '../../../_servies/theme_services/w_custon_theme_builder.dart';

class AccountCreatePage extends StatelessWidget {
  const AccountCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    AccountCreateController controller = Get.put(AccountCreateController());
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
              'Create New Account',
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
                          'Balance',
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
                  height: MediaQuery.of(context).size.height - 300,
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
                        TextField(
                          onTapOutside: (event) {
                            dismissKeyboard();
                          },
                          controller: controller.txtName,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            hintText: 'Name',
                            hintStyle: const TextStyle(
                                color: Color(0XFF91919F),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        const Gap(20),
                        ValueListenableBuilder(
                          valueListenable: controller.selectedType,
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
                                    'Account Type',
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
                                  items: dataController.accType
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
                                    controller.selectedType.value = newValue;
                                    controller.checkType(newValue);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const Gap(20),

                        ///<<<<<<<<<<<<<<Show Bank>>>>>>>>>>>>
                        ValueListenableBuilder(
                          valueListenable: controller.xShowBank,
                          builder: (context, value, child) {
                            return Visibility(
                              visible: value,
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankKBZ,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'KBZBANK', value);
                                              },
                                              child: MaxMultiButton2(
                                                image:
                                                    'assets/images/logo/KBZ_Bank_logo.png',
                                                value: value,
                                              ),
                                            );
                                          },
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankAYA,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'AYABANK', value);
                                              },
                                              child: MaxMultiButton2(
                                                image:
                                                    'assets/images/logo/AYA_Bank_logo.png',
                                                value: value,
                                              ),
                                            );
                                          },
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankYoma,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'YOMABANK', value);
                                              },
                                              child: MaxMultiButton2(
                                                image:
                                                    'assets/images/logo/logo.webp',
                                                value: value,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const Gap(10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankCB,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'CBBANK', value);
                                              },
                                              child: MaxMultiButton2(
                                                image:
                                                    'assets/images/logo/cb_bank_logo.png',
                                                value: value,
                                              ),
                                            );
                                          },
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankAGD,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'AGDBANK', value);
                                              },
                                              child: MaxMultiButton2(
                                                image:
                                                    'assets/images/logo/AGD.png',
                                                value: value,
                                              ),
                                            );
                                          },
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: controller.bankOther,
                                          builder: (context, value, child) {
                                            return GestureDetector(
                                              onTap: () {
                                                controller.controlBankList(
                                                    'OTHERBANK', value);
                                              },
                                              child: Container(
                                                width: 90,
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: value
                                                      ? const Color(0XFFEEE5FF)
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: value
                                                        ? Colors.transparent
                                                        : const Color(
                                                            0XFF0D0E0F),
                                                    width: 0.1,
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Other',
                                                    style: TextStyle(
                                                      color: value
                                                          ? theme.background
                                                          : const Color(
                                                              0XFF0D0E0F),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),

                        ///<<<<<<<<<<<<<<Show Mobile Bank>>>>>>>>>>>>
                        ValueListenableBuilder(
                          valueListenable: controller.xShowMobileBank,
                          builder: (context, value, child) {
                            return Visibility(
                              visible: value,
                              child: SizedBox(
                                height: 100,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: controller.kPay,
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.controlMobileBankList(
                                                'KPAY', value);
                                          },
                                          child: MaxMultiButton2(
                                            image:
                                                'assets/images/logo/k_pay.png',
                                            value: value,
                                            size: false,
                                          ),
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: controller.wavePay,
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.controlMobileBankList(
                                                'WAVEPAY', value);
                                          },
                                          child: MaxMultiButton2(
                                            image:
                                                'assets/images/logo/wave_pay.png',
                                            value: value,
                                            size: false,
                                          ),
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: controller.cbMobile,
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.controlMobileBankList(
                                                'CB', value);
                                          },
                                          child: MaxMultiButton2(
                                            image: 'assets/images/logo/CB.png',
                                            value: value,
                                            size: false,
                                          ),
                                        );
                                      },
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: controller.okDollar,
                                      builder: (context, value, child) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.controlMobileBankList(
                                                'OKDOLLAR', value);
                                          },
                                          child: MaxMultiButton2(
                                            image:
                                                'assets/images/logo/ok_dollar.png',
                                            value: value,
                                            size: false,
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
