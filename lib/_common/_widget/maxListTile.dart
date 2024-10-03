import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

import '../constants/app_svg.dart';

// ignore: must_be_immutable
class MaxListTile extends StatelessWidget {
  String title;
  String subtitle;
  double amount;
  DateTime time;
  bool transaction;
  MaxListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.time,
      required this.transaction});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: transaction ? incomeColor : outcomeColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: transaction
                  ? SvgPicture.string(AppSvgs.svgAddIncomeIcon)
                  : SvgPicture.string(AppSvgs.svgAddOutcomeIcon),
            ),
            title: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Text(
                  transaction ? '+$amount' : '-$amount',
                  style: TextStyle(
                    color: transaction ? incomeColor : outcomeColor,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  myTimeFormat(time),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        );
      },
    );
  }
}
