import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

import '../constants/app_svg.dart';

class MaxListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String transaction;
  const MaxListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.amount,
      required this.time,
      required this.transaction});

  @override
  Widget build(BuildContext context) {
    Color displayColor;
    String displayAmount = '';
    String displayIcon = '';
    if (transaction == "INCOME") {
      displayColor = incomeColor;
      displayAmount = "+${formatNumber(amount)}";
      displayIcon = AppSvgs.svgAddIncomeIcon;
    } else if (transaction == "EXPENSE") {
      displayColor = outcomeColor;
      displayAmount = "-${formatNumber(amount)}";
      displayIcon = AppSvgs.svgAddOutcomeIcon;
    } else if (transaction == "TRANSFER") {
      displayColor = transferColor;
      displayAmount = formatNumber(amount);
      displayIcon = AppSvgs.svgAddTransferIcon;
    } else {
      displayColor = background;
      displayAmount = "-$amount";
      displayIcon = AppSvgs.svgAddOutcomeIcon;
    }
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: displayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.string(displayIcon),
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 5),
                Text(
                  "$displayAmount Ks",
                  style: TextStyle(
                    color: displayColor,
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Text(
                  formatDateTimeForTile(time.add(addDuration_630)),
                  style: const TextStyle(
                    fontSize: 10,
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
