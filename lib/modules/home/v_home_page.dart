import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:fl_chart/fl_chart.dart';
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                //Leading Card
                Container(
                  width: double.infinity,
                  height: Get.width * 0.5,
                  decoration: const BoxDecoration(
                    color: Color(0XFFF8EDD8),
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
                                    ValueListenableBuilder(
                                      valueListenable: controller.totalIncome,
                                      builder: (context, totalIncome, child) {
                                        return Text(
                                          '$totalIncome Ks',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        );
                                      },
                                    )
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
                                    ValueListenableBuilder(
                                      valueListenable: controller.totalOutcome,
                                      builder: (context, totalOutcome, child) {
                                        return Text(
                                          '$totalOutcome Ks',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                          ),
                                        );
                                      },
                                    )
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
                const SizedBox(height: 10),
                //Spend Frequency
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      const Text(
                        'Spend Frequency',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Iconsax.refresh_left_square),
                      )
                    ],
                  ),
                ),
                //Line Chart
                Container(
                  width: double.infinity,
                  height: 200,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LineChart(
                    LineChartData(
                      // lineTouchData: const LineTouchData(enabled: false),
                      gridData: const FlGridData(show: false),
                      titlesData: const FlTitlesData(show: false),
                      borderData: FlBorderData(show: false),
                      lineBarsData: [
                        LineChartBarData(
                          color: theme.background,
                          barWidth: 5,
                          isCurved: true,
                          isStrokeCapRound: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                theme.background.withOpacity(0.5),
                                Colors.white.withOpacity(0.5)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          spots: const [
                            FlSpot(0, 0),
                            FlSpot(1, 1),
                            FlSpot(2, 1),
                            FlSpot(3, 4),
                            FlSpot(4, 5),
                            FlSpot(5, 2),
                            FlSpot(6, 3),
                          ],
                          dotData: const FlDotData(
                            show: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //Tab
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ValueListenableBuilder(
                    valueListenable: controller.tabIndex,
                    builder: (context, tabIndex, child) {
                      return AnimatedToggleSwitch<int>.size(
                        // current: min(tabIndex, 2),
                        height: 40,
                        current: tabIndex,
                        style: ToggleStyle(
                          backgroundColor: const Color(0XFFF8EDD8),
                          indicatorColor: const Color(0xFFE4C48A),
                          borderColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          indicatorBorderRadius: BorderRadius.circular(10),
                        ),
                        values: const [0, 1, 2, 3],
                        iconOpacity: 1.0,
                        selectedIconScale: 1.0,
                        indicatorSize: const Size.fromWidth(100),
                        iconAnimationType: AnimationType.onHover,
                        styleAnimationType: AnimationType.onHover,
                        spacing: 2.0,
                        customSeparatorBuilder: (context, local, global) {
                          final opacity =
                              ((global.position - local.position).abs() - 0.5)
                                  .clamp(0.0, 1.0);
                          return VerticalDivider(
                            indent: 10.0,
                            endIndent: 10.0,
                            color: Colors.black12.withOpacity(opacity),
                            // color: Colors.black,
                          );
                        },
                        customIconBuilder: (context, local, global) {
                          final text = const [
                            'Today',
                            'Week',
                            'Month',
                            'Year',
                          ][local.index];
                          return Center(
                            child: Text(
                              text,
                              style: TextStyle(
                                color: Color.lerp(Colors.black, Colors.white,
                                    local.animationValue),
                              ),
                            ),
                          );
                        },
                        borderWidth: 0.0,
                        onChanged: (i) {
                          controller.tabIndex.value = i;
                          print(i);
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      const Text(
                        'Recent Transaction',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('See All'),
                      ),
                    ],
                  ),
                ),
                //Cards
                SizedBox(
                  width: double.infinity,
                  height: 350,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        customCard('Shopping' * 4, 'Buy some grocery', '-50000',
                            '08:34 AM'),
                        customCard('Shopping', 'Buy some grocery' * 10,
                            '-50000', '08:34 AM'),
                        customCard('Shopping', 'Buy some grocery', '-50000',
                            '08:34 AM'),
                        customCard('Shopping', 'Buy some grocery', '-50000',
                            '08:34 AM'),
                      ],
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

  Widget customCard(String title, String subtitle, String amount, String time) {
    return Card(
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: const Color(0XFFFCAC12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.string(AppSvgs.addOutcomeIcon),
        ),
        title: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              amount,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Text(
              time,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
