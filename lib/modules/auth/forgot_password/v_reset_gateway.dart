import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/forgot_password/c_forgot_password.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';

class ResetGatewayPage extends StatelessWidget {
  const ResetGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    ForgotPasswordController controller = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const SizedBox(height: 30),
                SizedBox(
                  width: Get.width * 0.7,
                  height: Get.width * 0.7,
                  child: Image.asset(
                    'assets/images/reset_mail.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Column(
                    children: [
                      const Text(
                        'Your email is on the way',
                        style: TextStyle(
                          fontSize: 23,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Check your email ${controller.txtEmail.text} and follow the instructions to reset your password',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.off(()=>const LoginPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.background,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 100),
                    child: const Text(
                      "Back To Login",
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
