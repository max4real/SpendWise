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
// import 'package:spend_wise/modules/account/account_detail/c_account_detail.dart';
import 'package:spend_wise/modules/account/account_edit/v_account_edit.dart';

class AccountDetailPage extends StatelessWidget {
  const AccountDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // AccountDetailController controller = Get.put(AccountDetailController());
    DataController dataController = Get.find();
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
                  maxSnackBar(context, 'Delete Account');
                },
                icon: const Icon(
                  Iconsax.trash,
                  size: 22,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.to(() => const AccountEditPage());
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
                            dataController.getImage('KBZ Bank'),
                          ),
                        ),
                      ),
                      const Gap(10),
                      const Text(
                        'KBZ Bank',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Text(
                        '${formatNumber(45900)} Ks',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 23),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return MaxListTile(
                        title: 'Food',
                        subtitle: "lunch and dinner",
                        amount: 7500,
                        time: DateTime.now(),
                        transaction: index % 2 == 0 ? 'Income' : 'Expense',
                      );
                    },
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
