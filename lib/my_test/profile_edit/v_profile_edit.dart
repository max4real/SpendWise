import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    DataController dataController = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: theme.background,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Iconsax.arrow_left,
                color: Colors.white,
                size: 30,
              ),
            ),
            title: const Text(
              'Profile Edit',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          body: Container(
            color: Colors.yellow,
            width: 90,
            height: 90,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: theme.background.withOpacity(0.5),
                  child: ValueListenableBuilder(
                    valueListenable: dataController.meModelNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value.name[0].toUpperCase(),
                        style: const TextStyle(fontSize: 30),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 20,
                      )),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
