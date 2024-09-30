import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  ValueNotifier<bool> xObscured = ValueNotifier(true);
  ValueNotifier<bool?> xChecked = ValueNotifier(false);


  TextEditingController txtName = TextEditingController(text: '');
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
