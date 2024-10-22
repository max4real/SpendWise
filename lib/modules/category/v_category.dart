import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:spend_wise/_servies/theme_services/d_dark_theme.dart';
import 'package:spend_wise/modules/category/c_category.dart';

import '../../_common/constants/app_svg.dart';
import '../../_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
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
              'Category',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ValueListenableBuilder(
                valueListenable: controller.xFetching,
                builder: (context, xFetching, child) {
                  if (xFetching) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ValueListenableBuilder(
                      valueListenable: controller.categoryList,
                      builder: (context, categoryList, child) {
                        if (categoryList.isEmpty) {
                          return const Center(
                            child: Text("No Data Yet!"),
                          );
                        } else {
                          return SlidableAutoCloseBehavior(
                            child: ListView.builder(
                              itemCount: categoryList.length,
                              itemBuilder: (context, index) {
                                return Slidable(
                                  key: const ValueKey(0),
                                  // key: GlobalKey(),
                                  // groupTag: 'savedPlace',
                                  // closeOnScroll: true,
                                  enabled: categoryList[index].categoryPrivacy,
                                  endActionPane: ActionPane(
                                    extentRatio: 0.2,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          controller.deleteCategory(
                                              categoryList[index].categoryID);
                                        },
                                        backgroundColor: outcomeColor,
                                        foregroundColor: Colors.white,
                                        icon: Iconsax.trash,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: tile(
                                          categoryList[index].categoryName,
                                          categoryList[index].categoryPrivacy,
                                        ),
                                      ),
                                      const Divider(
                                        height: 0,
                                        thickness: 0.3,
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              )),
        );
      },
    );
  }

  Widget tile(String name, bool xPrivate) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          SvgPicture.string(AppSvgs.svgGreenDot),
          const Gap(10),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF5D5C5C),
            ),
          ),
          const Spacer(),
          Text(
            xPrivate ? 'Private' : 'Default',
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D5C5C),
            ),
          ),
        ],
      ),
    );
  }
}
