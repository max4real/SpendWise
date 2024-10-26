import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/models/m_transaction_list_model.dart';

// ignore: must_be_immutable
class TransactionDetailsPage extends StatelessWidget {
  final TransactionListModel transactionListModel;
  const TransactionDetailsPage({super.key, required this.transactionListModel});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (transactionListModel.tarnType == 'INCOME') {
      color = incomeColor;
    } else if (transactionListModel.tarnType == 'EXPENSE') {
      color = outcomeColor;
    } else if (transactionListModel.tarnType == 'TRANSFER') {
      color = transferColor;
    } else {
      color = background;
    }
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
                onPressed: () {
                  showDeleteSheet();
                },
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
                            '${formatNumber(transactionListModel.amount)} Ks',
                            style: const TextStyle(
                              fontSize: 35,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const Gap(10),
                          Text(
                            transactionListModel.remark,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Gap(20),
                          Text(
                            myFullDateTimeFormat(transactionListModel.createdAt
                                .add(addDuration_630)),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 235, 234, 234),
                              fontWeight: FontWeight.w600,
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
                          child: Card(
                            elevation: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Type',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: Color(0XFF91919F),
                                        ),
                                      ),
                                      const Gap(10),
                                      Text(
                                        transactionListModel.tarnType,
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0XFF0D0E0F),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: transactionListModel.tarnType ==
                                          "TRANSFER"
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'From',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0XFF91919F),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              transactionListModel.from != null
                                                  ? transactionListModel.from!
                                                  : '-',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF0D0E0F),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Category',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0XFF91919F),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              transactionListModel.category !=
                                                      null
                                                  ? transactionListModel
                                                      .category!.categoryName
                                                  : '-',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF0D0E0F),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: transactionListModel.tarnType ==
                                          "TRANSFER"
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'To',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0XFF91919F),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              transactionListModel.to != null
                                                  ? transactionListModel.to!
                                                  : "-",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF0D0E0F),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Wallet',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Color(0XFF91919F),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              transactionListModel.subType !=
                                                      null
                                                  ? transactionListModel
                                                      .subType!
                                                  : "-",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF91919F),
                            fontSize: 16),
                      ),
                      const Gap(10),
                      Text(
                        transactionListModel.description != null
                            ? transactionListModel.description!
                            : 'No Description',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0XFF0D0E0F),
                        ),
                      ),
                      const Gap(15),
                      SvgPicture.string(AppSvgs.svgDottedLine),
                      const Gap(10),
                      const Text(
                        'Attachment',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0XFF91919F),
                            fontSize: 16),
                      ),
                      const Gap(10),
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: transactionListModel.image != null &&
                                  transactionListModel.image!.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    Get.dialog(
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 100),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Hero(
                                            tag: transactionListModel.image!,
                                            child: Image.network(
                                              filterQuality: FilterQuality.high,
                                              transactionListModel.image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: transactionListModel.image!,
                                    child: Image.network(
                                      filterQuality: FilterQuality.low,
                                      transactionListModel.image!,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      (loadingProgress
                                                              .expectedTotalBytes ??
                                                          1)
                                                  : null,
                                            ),
                                          );
                                          // return const Center(
                                          //   child: CircularProgressIndicator(),
                                          // );
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: Text(
                                    'No Attachment',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF91919F),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      // const Gap(23),
                      // GestureDetector(
                      //   onTap: () {
                      //     // Get.to(() => const VerificationPage());
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: theme.background,
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     padding: const EdgeInsets.symmetric(
                      //         vertical: 13, horizontal: 110),
                      //     child: const Text(
                      //       "Edit",
                      //       style: TextStyle(
                      //         fontSize: 18,
                      //         color: Colors.white,
                      //         fontWeight: FontWeight.w400,
                      //       ),
                      //     ),
                      //   ),
                      // ),
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

  void showDeleteSheet() {
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
                    "Remove this transaction?",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Are you sure do you wanna remove this transaction?",
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
                          //Delete code
                          maxSuccessDialog(
                              'Transaction has been successfully removed',
                              true);
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
