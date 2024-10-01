import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/home/c_home_page.dart';

import '../../_common/constants/app_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = Get.put(HomePageController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          // backgroundColor: const Color(0XFF1E1E1E),
          appBar: AppBar(
            backgroundColor: const Color(0XFFF8EDD8),
            leading: const Icon(
              Iconsax.menu,
              size: 30,
            ),
            centerTitle: true,
            title: const Text(
              "October",
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Iconsax.notification_bing,
                  color: theme.background,
                ),
              )
            ],
          ),
          body: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: Get.width * 0.5,
                    decoration: const BoxDecoration(
                      color: Color(0XFFF8EDD8),
                      // gradient: LinearGradient(
                      //   colors: [
                      //     const Color(0XFFF8EDD8),
                      //     Colors.white,
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Account Balance',
                            style: TextStyle(color: Color(0XFF91919F)),
                          ),
                          ValueListenableBuilder(
                            valueListenable: controller.totalBalance,
                            builder: (context, totalBalance, child) {
                              return Text(
                                '$totalBalance Ks',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(right: 9),
                                  padding: const EdgeInsets.all(15),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0XFF00A86B),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.string(
                                            height: 30,
                                            width: 30,
                                            AppSvgs.IncomeIcon,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Income',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '1200000' + ' Ks',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 9),
                                  padding: const EdgeInsets.all(15),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: const Color(0XFFFD3C4A),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.string(
                                            height: 30,
                                            width: 30,
                                            AppSvgs.OutcomeIcon,
                                          ),
                                          const SizedBox(width: 10),
                                          const Text(
                                            'Outcome',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 17,
                                            ),
                                          )
                                        ],
                                      ),
                                      const Spacer(),
                                      const Text(
                                        '75000' + ' Ks',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 500,
                    color: Colors.grey,
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
