import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/auth/forgot_password/reset_password/c_reset_password.dart';
import 'package:get/get.dart';

import '../../../../_common/data/data_controller.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ResetPasswordController controller = Get.put(ResetPasswordController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Reset Password',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    controller: controller.txtNewPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'New Password',
                      hintStyle: const TextStyle(
                          color: Color(0XFF91919F),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    controller: controller.txtReNewPassword,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Confirm New Password',
                      hintStyle: const TextStyle(
                          color: Color(0XFF91919F),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      controller.proceedToReset();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 120),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
