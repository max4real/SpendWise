import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spend_wise/_common/constants/app_svg.dart';
import 'package:spend_wise/_common/data/data_controller.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:spend_wise/modules/account/v_account_list.dart';
import 'package:spend_wise/modules/category/v_category.dart';
import 'package:spend_wise/modules/profile/c_profile.dart';
import 'package:get/get.dart';
import 'package:spend_wise/modules/profile/profile_edit/v_profile_edit.dart';
import 'package:spend_wise/modules/setting/v_setting.dart';

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
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18, top: 30),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: theme.background.withOpacity(0.5),
                          child: ValueListenableBuilder(
                            valueListenable: dataController.meModelNotifier,
                            builder: (context, value, child) {
                              return Text(
                                value.name[0].toUpperCase(),
                                style: const TextStyle(fontSize: 40),
                              );
                            },
                          ),
                        ),
                        const Gap(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: dataController.meModelNotifier,
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
                            SizedBox(
                              width: 180,
                              child: ValueListenableBuilder(
                                valueListenable: dataController.meModelNotifier,
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
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const ProfileEditPage());
                            // dataController.meModelNotifier.value = MeModel(
                            //   name: 'helloooo',
                            //   email: 'hello@gmail.com',
                            //   image: 'image',
                            //   totalBalance: 0,
                            //   totalIncome: 0,
                            //   totoalExpense: 0,
                            // );
                          },
                          child: SvgPicture.string(AppSvgs.svgProfileEdit),
                        )
                      ],
                    ),
                  ),
                  // const Gap(20),
                  const Divider(),
                  Column(
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
// Card(
//                       elevation: 10,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 18),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 SvgPicture.string(AppSvgs.svgProfileAccount),
//                                 const Gap(10),
//                                 Text(
//                                   'Account',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
