import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController {
  ValueNotifier<bool> xObscured = ValueNotifier(true);

  TextEditingController txtEmail = TextEditingController(text: '');
  TextEditingController txtPassword = TextEditingController(text: '');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initLoad();
  }

  void initLoad() {}
}
