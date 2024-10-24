import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/account_setup/v_account_setup.dart';

import '../main_page/v_main_page.dart';

class SetupGateway extends StatelessWidget {
  const SetupGateway({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              TextButton(
                onPressed: () {
                  Get.offAll(() => const MainPage());
                },
                child: const Text('Skip'),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    'Let’s setup your account!',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Account can be your bank, mobile bank or your wallet.',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AccountSetupPage());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 100),
                      child: const Text(
                        "Let’s go",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
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
