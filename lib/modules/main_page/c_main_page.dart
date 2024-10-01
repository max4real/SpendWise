import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum EnumMainPageTab {
  home(label: "Home", icon: Icon(Icons.home)),
  transaction(label: "Transaction", icon: Icon(Icons.transform)),
  budget(label: "Budget", icon: Icon(Icons.pie_chart_sharp)),
  profile(label: "Profile", icon: Icon(Icons.person));

  final String label;
  final Icon icon;
  const EnumMainPageTab({required this.label, required this.icon});
}

class MainPageController extends GetxController with GetTickerProviderStateMixin{
  ValueNotifier<EnumMainPageTab> currentTab = ValueNotifier(EnumMainPageTab.home);
  late AnimationController tabChangeAnimation;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }
   Future<void> initLoad() async{
    tabChangeAnimation = AnimationController(vsync: this,duration: const Duration(milliseconds: 200),value: 1);
  }

  void updateTab({required EnumMainPageTab tab}) async{
    await tabChangeAnimation.reverse();
    currentTab.value = tab;
    await tabChangeAnimation.forward();
  }
}
