import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/account/v_account_list.dart';
import 'package:spend_wise/modules/category/v_category.dart';
import 'package:spend_wise/modules/profile/c_profile.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/setting/v_setting.dart';
import 'package:spend_wise/my_test/profile_edit/v_profile_edit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());
    DataController dataController = Get.find();
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: const Color(0XFFF6F6F6),
          body: SafeArea(
            child: Column(
              children: [
                //Leading Card
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      // decoration: const BoxDecoration(
                      //   color: Colors.deepOrange,
                      // ),
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Stack(
                        children: [
                          SvgPicture.string(
                            AppSvgs.svgAccountBG,
                            fit: BoxFit.fill,
                          ),
                          BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                            child: Container(
                              color: Colors.black
                                  .withOpacity(0), // Keep this transparent
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.95,
                          height: 120,
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 90,
                                    height: 90,
                                    child: Stack(
                                      children: [
                                        ValueListenableBuilder(
                                          valueListenable:
                                              controller.selectedImage,
                                          builder: (context, value, child) {
                                            if (value != null) {
                                              return CircleAvatar(
                                                radius: 40,
                                                backgroundColor: theme
                                                    .background
                                                    .withOpacity(0.5),
                                                foregroundImage: FileImage(
                                                  getImageFile(value),
                                                ),
                                              );
                                            } else {
                                              return CircleAvatar(
                                                radius: 40,
                                                backgroundColor: theme
                                                    .background
                                                    .withOpacity(0.5),
                                                // foregroundImage: NetworkImage(
                                                //   dataController
                                                //       .meModelNotifier.value.image,
                                                // ),
                                                //switch to Network Image
                                                foregroundImage: AssetImage(
                                                  'assets/images/image.png',
                                                ),
                                                child: ValueListenableBuilder(
                                                  valueListenable:
                                                      dataController
                                                          .meModelNotifier,
                                                  builder:
                                                      (context, value, child) {
                                                    return Text(
                                                      value.name[0]
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 40),
                                                    );
                                                  },
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: IconButton(
                                            onPressed: () {
                                              controller.pickImage();
                                            },
                                            icon: const Icon(
                                              Icons.add_a_photo_outlined,
                                              size: 20,
                                              color: Color(0XFF161719),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Gap(20),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ValueListenableBuilder(
                                        valueListenable:
                                            dataController.meModelNotifier,
                                        builder: (context, value, child) {
                                          return Text(
                                            value.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 19,
                                                color: Color(0XFF161719)),
                                          );
                                        },
                                      ),
                                      const Gap(8),
                                      SizedBox(
                                        width: 180,
                                        child: ValueListenableBuilder(
                                          valueListenable:
                                              dataController.meModelNotifier,
                                          builder: (context, value, child) {
                                            return Text(
                                              value.email,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Color(0XFF91919F)),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        children: [
                          Card(
                            child: ListTile(
                              minTileHeight: 70,
                              onTap: () {
                                Get.to(() => const AccountListPage());
                              },
                              leading: SvgPicture.string(
                                AppSvgs.svgProfileAccount,
                                width: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              title: const Text(
                                'Account',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minTileHeight: 70,
                              onTap: () {
                                Get.to(() => const CategoryPage());
                              },
                              leading: SvgPicture.string(
                                AppSvgs.svgCategory,
                                width: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              title: const Text(
                                'Category',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minTileHeight: 70,
                              onTap: () {
                                Get.to(() => const SettingPage());
                              },
                              leading: SvgPicture.string(
                                AppSvgs.svgProfileSetting,
                                width: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              title: const Text(
                                'Settings',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minTileHeight: 70,
                              onTap: () {
                                maxSnackBar(context, "Coming Soon!");
                                Get.to(() => ProfileEditPage());
                              },
                              leading: SvgPicture.string(
                                AppSvgs.svgProfileExport,
                                width: 40,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              title: const Text(
                                'Export Data',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              minTileHeight: 70,
                              onTap: () {
                                controller.logOut();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13.0),
                              ),
                              leading: SvgPicture.string(
                                AppSvgs.svgProfileLogout,
                                width: 40,
                              ),
                              title: const Text(
                                'Logout',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  File getImageFile(XFile? pickedFile) {
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      return File('');
    }
  }
}
