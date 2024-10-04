import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class TransactionDetailsPage extends StatelessWidget {
  Color color;
  TransactionDetailsPage({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          // backgroundColor: outcomeColor,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: color,
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
              'Transaction Details',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Iconsax.trash,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Leading Card
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          const Gap(10),
                          Text(
                            "53000" + ' Ks',
                            style: TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            'Salary for July',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            myFullDateTimeFormat(DateTime.now()),
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 230,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: 90,
                          child: const Card(
                            elevation: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0XFF91919F),
                                        ),
                                      ),
                                      Gap(10),
                                      Text(
                                        "Expense",
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF0D0E0F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Category',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0XFF91919F),
                                        ),
                                      ),
                                      Gap(10),
                                      Text(
                                        'Shopping',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF0D0E0F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Wallet',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0XFF91919F),
                                        ),
                                      ),
                                      Gap(10),
                                      Text(
                                        'Cash',
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF0D0E0F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(15),
                SvgPicture.string(AppSvgs.svgDottedLine),
                const Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF91919F),
                              fontSize: 16),
                        ),
                      ),
                      const Gap(10),
                      Text(
                        "blahhh balha sdfs" * 20,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0XFF0D0E0F),
                        ),
                      ),
                      const Gap(10),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Attachment',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0XFF91919F),
                              fontSize: 16),
                        ),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/image.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const Gap(23),
                      GestureDetector(
                        onTap: () {
                          // Get.to(() => const VerificationPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: theme.background,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 110),
                          child: const Text(
                            "Edit",
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
