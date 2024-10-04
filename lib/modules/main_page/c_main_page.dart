import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

enum EnumMainPageTab {
  // home(label: "Home", icon: AppSvgs.mainHomeIcon),
  // transaction(label: "Transaction", icon: AppSvgs.mainProfileIcon),
  // budget(label: "Budget", icon: AppSvgs.mainProfileIcon),
  // profile(label: "Profile", icon: AppSvgs.mainProfileIcon);
  home(label: "Home", icon: Icon(Iconsax.home)),
  transaction(label: "Transaction", icon: Icon(Iconsax.transaction_minus)),
  budget(label: "Budget", icon: Icon(Iconsax.money)),
  profile(label: "Profile", icon: Icon(Iconsax.profile_2user));

  final String label;
  final Icon icon;
  const EnumMainPageTab({required this.label, required this.icon});
}

class MainPageController extends GetxController
    with GetTickerProviderStateMixin {
  ValueNotifier<EnumMainPageTab> currentTab =
      ValueNotifier(EnumMainPageTab.home);
  ValueNotifier<bool> showFAB = ValueNotifier(true);
  late AnimationController tabChangeAnimation;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  Future<void> initLoad() async {
    tabChangeAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200), value: 1);
  }

  void updateTab({required EnumMainPageTab tab}) async {
    await tabChangeAnimation.reverse();
    currentTab.value = tab;
    await tabChangeAnimation.forward();
  }
}
