import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            // backgroundColor: theme.background,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.black,
                size: 30,
              ),
            ),
            title: const Text(
              'Setting',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Placeholder(),
        );
      },
    );
  }
}
