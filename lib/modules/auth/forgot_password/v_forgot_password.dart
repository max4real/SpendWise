import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/auth/forgot_password/c_forgot_password.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/forgot_password/v_reset_gateway.dart';

import '../../../_common/data/data_controller.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController controller = Get.put(ForgotPasswordController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Forgot Password',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  const Text(
                    'Don’t worry.\nEnter your email and we’ll send you a link to reset your password.',
                    style: TextStyle(fontSize: 22),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    onTapOutside: (event) {
                      dismissKeyboard();
                    },
                    controller: controller.txtEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          color: Color(0XFF91919F),
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Get.off(() => const ResetGatewayPage());
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
