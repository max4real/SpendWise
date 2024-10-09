import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/account/account_create/v_account_create.dart';
import 'package:spend_wise/modules/account/account_detail/v_account_detail.dart';

class AccountListPage extends StatelessWidget {
  const AccountListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // AccountListController controller = Get.put(AccountListController());
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
              'Accounts',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 180,
                child: Stack(
                  children: [
                    SvgPicture.string(
                      AppSvgs.svgAccountBG,
                      fit: BoxFit.fill,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        color: Colors.black
                            .withOpacity(0), // Keep this transparent
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Account Balance",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0XFF91919F),
                            ),
                          ),
                          Text(
                            "${formatNumber(154000)} Ks",
                            style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const AccountDetailPage());
                      },
                      child: Card(
                        margin: const EdgeInsets.all(3),
                        elevation: 0.5,
                        child: ListTile(
                          leading: SvgPicture.string(AppSvgs.svgAccountWallet),
                          title: const Text(
                            "Wallet",
                            style: TextStyle(fontSize: 16),
                          ),
                          trailing: Text(
                            '${formatNumber(540000)} Ks',
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(10),
              GestureDetector(
                onTap: () {
                  Get.to(() => const AccountCreatePage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: theme.background,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 80),
                  child: const Text(
                    '+ Add new wallet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const Gap(15)
            ],
          ),
        );
      },
    );
  }
}
