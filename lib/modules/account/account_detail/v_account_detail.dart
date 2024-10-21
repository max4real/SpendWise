import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/_widget/maxListTile.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/models/m_account_model.dart';
import 'package:spend_wise/modules/account/account_detail/c_account_detail.dart';
// import 'package:spend_wise/modules/account/account_detail/c_account_detail.dart';
import 'package:spend_wise/modules/account/account_edit/v_account_edit.dart';

class AccountDetailPage extends StatelessWidget {
  final AccountModel accountModel;
  const AccountDetailPage({super.key, required this.accountModel});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    AccountDetailController controller = Get.put(AccountDetailController());
    controller.initLoad(accountModel);
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
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
              'Account Detail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDeleteSheet();
                },
                icon: const Icon(
                  Iconsax.trash,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => AccountEditPage(
                        accountModel: accountModel,
                      ));
                },
                icon: SvgPicture.string(
                  AppSvgs.svgProfileEdit,
                  width: 25,
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 4,
                        color: const Color(0XFFF1F1FA),
                        child: Container(
                          height: 60,
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            dataController.getImage(accountModel.accSubType),
                          ),
                        ),
                      ),
                      const Gap(10),
                      ValueListenableBuilder(
                        valueListenable: controller.accName,
                        builder: (context, value, child) {
                          return Text(
                            value,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          );
                        },
                      ),
                      Text(
                        '${formatNumber(accountModel.accBalance)} Ks',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ValueListenableBuilder(
                  valueListenable: controller.xFetching,
                  builder: (context, xFetching, child) {
                    if (xFetching) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ValueListenableBuilder(
                        valueListenable: controller.transactionList,
                        builder: (context, transactionList, child) {
                          return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return MaxListTile(
                                title: 'Food',
                                subtitle: "lunch and dinner",
                                amount: 7500,
                                time: DateTime.now(),
                                transaction:
                                    index % 2 == 0 ? 'Income' : 'Expense',
                              );
                            },
                          );
                        },
                      );
                    }
                  },
                ))
              ],
            ),
          ),
        );
      },
    );
  }

  void showDeleteSheet() {
    AccountDetailController controller = Get.find();
    Get.bottomSheet(
      backgroundColor: Colors.white,
      MaxThemeBuilder(
        builder: (context, theme, themeController) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 18,
              right: 18,
              top: 18,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 200,
              child: Column(
                children: [
                  const Text(
                    "Delete this Account?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Are you sure do you wanna delete this Account?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0XFF91919F),
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.background2,
                          minimumSize: const Size(150, 40),
                        ),
                        child: Text(
                          "No",
                          style:
                              TextStyle(color: theme.background, fontSize: 18),
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                          controller.deleteAccount();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.background,
                          minimumSize: const Size(150, 40),
                        ),
                        child: Text(
                          "Yes",
                          style: TextStyle(color: theme.text1, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
