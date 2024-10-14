import 'package:flutter/material.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/modules/auth/forgot_password/v_forgot_password.dart';
import 'package:spend_wise/modules/auth/login/c_login_page.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/sign_up/v_signup_page.dart';

import '../../../_servies/theme_services/w_custon_theme_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginPageController controller = Get.put(LoginPageController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Login',
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
                  ValueListenableBuilder(
                    valueListenable: controller.xObscured,
                    builder: (context, value, child) {
                      return TextField(
                        onTapOutside: (event) {
                          dismissKeyboard();
                        },
                        obscureText: value,
                        controller: controller.txtPassword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              color: Color(0XFF91919F),
                              fontWeight: FontWeight.w400),
                          suffixIcon: IconButton(
                            onPressed: () {
                              controller.xObscured.value =
                                  !controller.xObscured.value;
                            },
                            icon: value
                                ? const Icon(Icons.visibility_off_outlined)
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: theme.background,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 45),
                  GestureDetector(
                    onTap: () {
                      controller.proceedToLogin();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 130),
                      child: const Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const ForgotPasswordPage());
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 15,
                        color: theme.background,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don’t have an account yet?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const SignUpPage());
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 15,
                            color: theme.background,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
