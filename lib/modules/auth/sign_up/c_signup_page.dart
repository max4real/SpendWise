import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:spend_wise/_common/data/data_controller.dart';

import '../verification/v_verification_page.dart';

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

  void checkAllField() {
    if (txtName.text.isEmpty) {
      maxMessageDialog('Please Enter Name.');
    } else if (txtEmail.text.isEmpty) {
      maxMessageDialog('Please Enter Email.');
    } else if (txtPassword.text.isEmpty) {
      maxMessageDialog('Please Enter Password.');
    } else if (xChecked.value == false) {
      maxMessageDialog('Please Check The Box');
    }
  }

  void proceedToVarification() {
    checkAllField();
    if (txtName.text.isNotEmpty &&
        txtEmail.text.isNotEmpty &&
        txtPassword.text.isNotEmpty &&
        xChecked.value == true) {
      Get.to(() => const VerificationPage());
    }
  }
}
