import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
// import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/create_new/outcome_new/v_outcome_new.dart';
import 'package:spend_wise/modules/create_new/transfer_new/v_transfer_new.dart';
import 'package:spend_wise/modules/home/v_home_page.dart';
import 'package:spend_wise/modules/main_page/c_main_page.dart';

import '../create_new/income_new/v_income_new.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());
    // DataController dataController = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          floatingActionButtonLocation: ExpandableFab.location,
          floatingActionButton: ExpandableFab(
            type: ExpandableFabType.fan,
            pos: ExpandableFabPos.right,
            childrenAnimation: ExpandableFabAnimation.rotate,
            distance: 90,
            openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
              backgroundColor: theme.background.withOpacity(0.7),
            ),
            overlayStyle: ExpandableFabOverlayStyle(
              color: Colors.black.withOpacity(0.5),
              blur: 5,
            ),
            children: [
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: const Color(0XFF00A86B),
                // child: const Icon(Icons.edit),
                child: SvgPicture.string(AppSvgs.addIncomeIcon),
                onPressed: () {
                  Get.to(() => const IncomeNewPage());
                },
              ),
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: const Color(0XFF0077FF),
                child: SvgPicture.string(AppSvgs.addTransferIcon),
                onPressed: () {
                  Get.to(() => const TransferNewPage());
                },
              ),
              FloatingActionButton.small(
                heroTag: null,
                backgroundColor: const Color(0XFFFD3C4A),
                child: SvgPicture.string(AppSvgs.addOutcomeIcon),
                onPressed: () {
                  Get.to(() => const OutcomeNewPage());
                },
              ),
            ],
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: controller.currentTab,
            builder: (context, currentTab, child) {
              return BottomNavigationBar(
                elevation: 1,
                selectedItemColor: theme.background,
                selectedIconTheme: IconThemeData(color: theme.background),
                showSelectedLabels: true,
                iconSize: 22,
                // showUnselectedLabels: true,
                unselectedItemColor: const Color(0XFFC6C6C6),
                currentIndex: EnumMainPageTab.values.indexOf(currentTab),
                items: EnumMainPageTab.values.map(
                  (e) {
                    bool xSelected = currentTab == e;
                    return BottomNavigationBarItem(
                      backgroundColor: const Color(0XFFFCFCFC),
                      // icon: SvgPicture.string(
                      //   e.icon,
                      //   colorFilter: ColorFilter.mode(
                      //     xSelected ? theme.background : Colors.grey,
                      //     BlendMode.srcIn,
                      //   ),
                      // ),
                      icon: Icon(
                        e.icon.icon,
                        color: xSelected ? theme.background : Colors.grey,
                      ),
                      label: e.label,
                    );
                  },
                ).toList(),
                onTap: (value) {
                  controller.updateTab(tab: EnumMainPageTab.values[value]);
                },
              );
            },
          ),
          body: AnimatedBuilder(
            animation: controller.tabChangeAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: controller.tabChangeAnimation.value,
                child: ValueListenableBuilder(
                  valueListenable: controller.currentTab,
                  builder: (context, currentTab, child) {
                    switch (currentTab) {
                      case EnumMainPageTab.home:
                        return const HomePage();
                      case EnumMainPageTab.transaction:
                        return const HomePage();
                      case EnumMainPageTab.budget:
                        return const HomePage();
                      case EnumMainPageTab.profile:
                        return const HomePage();
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
