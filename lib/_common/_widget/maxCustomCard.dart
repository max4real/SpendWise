import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spend_wise/_common/_widget/maxTag.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

import '../constants/app_svg.dart';

// ignore: must_be_immutable
class MaxCustonCard extends StatelessWidget {
  String tag;
  bool xExceed;
  double totoal;
  double used;
  double remaining;
  MaxCustonCard(
      {super.key,
      required this.tag,
      required this.xExceed,
      required this.totoal,
      required this.used,
      required this.remaining});

  @override
  Widget build(BuildContext context) {
    double progressValue = (used - 0) / (totoal - 0);

    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Column(
              children: [
                Row(
                  children: [
                    MaxTag(text: tag),
                    const Spacer(),
                    Visibility(
                      visible: xExceed,
                      child: SvgPicture.string(AppSvgs.svgExceedDot),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Remaining ${formatNumber(remaining)} Ks',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0XFF0D0E0F),
                    ),
                  ),
                ),
                const Gap(10),
                SizedBox(
                  height: 15,
                  width: double.infinity,
                  child: LinearProgressIndicator(
                    value: progressValue,
                    borderRadius: BorderRadius.circular(10),
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(theme.background),
                  ),
                ),
                const Gap(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${formatNumber(used)} Ks Spend of ${formatNumber(totoal)} Ks',
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0XFF0D0E0F),
                    ),
                  ),
                ),
                const Gap(10),
                Visibility(
                  visible: xExceed,
                  child: const Text(
                    'You’ve exceed the limit!',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0XFFFD3C4A),
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
