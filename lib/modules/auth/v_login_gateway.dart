import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/auth/c_login_gateway.dart';
import 'package:spend_wise/modules/auth/login/v_login_page.dart';
import 'package:spend_wise/modules/auth/sign_up/v_signup_page.dart';

import '../../_servies/theme_services/w_custon_theme_builder.dart';

class LoginGatewayPage extends StatelessWidget {
  const LoginGatewayPage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginGatewayController controller = Get.put(LoginGatewayController());
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.primary,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: Get.height * 0.6,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.2,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayAnimationDuration:
                              const Duration(milliseconds: 500),
                          autoPlayCurve: Curves.easeIn,
                          onPageChanged: (index, reason) {
                            controller.carouselIndex.value = index;
                          },
                        ),
                        items: controller.carouselList.map((each) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Image.asset(each.image),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Text(
                                        textAlign: TextAlign.center,
                                        each.title,
                                        style: const TextStyle(
                                            color: Color(0xFF212325),
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        each.body,
                                        style: const TextStyle(
                                            color: Color(0xFF91919F),
                                            fontSize: 15),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      ValueListenableBuilder(
                        valueListenable: controller.carouselIndex,
                        builder: (context, value, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.carouselList
                                .asMap()
                                .entries
                                .map((entry) {
                              return Container(
                                width:
                                    controller.carouselIndex.value == entry.key
                                        ? 14
                                        : 12,
                                height:
                                    controller.carouselIndex.value == entry.key
                                        ? 14
                                        : 12,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: controller.carouselIndex.value ==
                                          entry.key
                                      ? theme.background
                                      : Colors.grey.withOpacity(0.5),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const LoginPage());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme.background,
                      minimumSize: const Size(300, 50)),
                  child: Text(
                    "Login",
                    style: TextStyle(color: theme.text1, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => const SignUpPage());
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: theme.background2,
                      minimumSize: const Size(300, 50)),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: theme.background, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
