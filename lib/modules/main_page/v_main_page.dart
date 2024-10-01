import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/home/v_home_page.dart';
import 'package:spend_wise/modules/main_page/c_main_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainPageController());
    // DataController dataController = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: theme.background,
            child: Icon(Icons.add,size: 30,color: theme.text1,),
          ),
          bottomNavigationBar: ValueListenableBuilder(
            valueListenable: controller.currentTab,
            builder: (context, currentTab, child) {
              return BottomNavigationBar(
                elevation: 1,
                selectedItemColor: theme.background,
                selectedIconTheme: IconThemeData(color: theme.background),
                showSelectedLabels: true,
                iconSize: 26,
                // showUnselectedLabels: true,
                unselectedItemColor: const Color(0XFFC6C6C6),
                currentIndex: EnumMainPageTab.values.indexOf(currentTab),
                items: EnumMainPageTab.values.map(
                  (e) {
                    return BottomNavigationBarItem(
                      backgroundColor: const Color(0XFFFCFCFC),
                      icon: e.icon,
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
