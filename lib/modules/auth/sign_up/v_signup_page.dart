import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/sign_up/c_signup_page.dart';
import 'package:get/get.dart';

import '../../../_common/data/data_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpController controller = Get.put(SignUpController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Sign Up',
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
                    controller: controller.txtName,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Name',
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
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      ValueListenableBuilder(
                        valueListenable: controller.xChecked,
                        builder: (context, value, child) {
                          return Checkbox(
                            checkColor: Colors.white,
                            activeColor: theme.background,
                            value: value,
                            onChanged: (xValue) {
                              controller.xChecked.value = xValue;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        width: Get.width * 0.7,
                        child: RichText(
                          text: TextSpan(
                            text: 'By signing up, you agree to the ',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms of Service and Privacy Policy',
                                style: TextStyle(color: theme.background),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      controller.proceedToVarification();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 110),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(() => const LoginPage());
                        },
                        child: Text(
                          "Login",
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
