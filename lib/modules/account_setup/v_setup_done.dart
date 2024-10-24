import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';
import 'package:get/get.dart';

import '../main_page/v_main_page.dart';

class SetupDone extends StatefulWidget {
  const SetupDone({super.key});

  @override
  State<SetupDone> createState() => _SetupDoneState();
}

class _SetupDoneState extends State<SetupDone> {
  @override
  void initState() {
    super.initState();
    initLoad();
  }

  Future<void> initLoad() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAll(() => const MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(
                      width: 70,
                      height: 70,
                      """<svg width="96" height="96" viewBox="0 0 96 96" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M48 0C38.5065 0 29.2262 2.81515 21.3326 8.08946C13.4391 13.3638 7.2868 20.8603 3.6538 29.6312C0.0207901 38.402 -0.92977 48.0532 0.92232 57.3643C2.77441 66.6754 7.34597 75.2282 14.0589 81.9411C20.7718 88.654 29.3246 93.2256 38.6357 95.0777C47.9468 96.9298 57.598 95.9792 66.3688 92.3462C75.1397 88.7132 82.6362 82.5609 87.9106 74.6674C93.1849 66.7738 96 57.4935 96 48C96 35.2696 90.9429 23.0606 81.9411 14.0589C72.9394 5.05713 60.7304 0 48 0ZM70.64 38.36L48 60.96C45.75 63.2072 42.7 64.4694 39.52 64.4694C36.34 64.4694 33.29 63.2072 31.04 60.96L25.36 55.32C24.9871 54.947 24.6912 54.5043 24.4894 54.017C24.2875 53.5297 24.1836 53.0074 24.1836 52.48C24.1836 51.9526 24.2875 51.4303 24.4894 50.943C24.6912 50.4557 24.9871 50.013 25.36 49.64C25.733 49.267 26.1757 48.9712 26.663 48.7694C27.1503 48.5675 27.6726 48.4636 28.2 48.4636C28.7275 48.4636 29.2497 48.5675 29.737 48.7694C30.2243 48.9712 30.6671 49.267 31.04 49.64L36.68 55.32C37.0519 55.6949 37.4943 55.9925 37.9817 56.1956C38.4691 56.3986 38.992 56.5032 39.52 56.5032C40.0481 56.5032 40.5709 56.3986 41.0583 56.1956C41.5458 55.9925 41.9882 55.6949 42.36 55.32L64.96 32.68C65.333 32.307 65.7757 32.0112 66.263 31.8094C66.7503 31.6075 67.2726 31.5036 67.8 31.5036C68.3275 31.5036 68.8497 31.6075 69.337 31.8094C69.8243 32.0112 70.2671 32.307 70.64 32.68C71.013 33.053 71.3088 33.4957 71.5107 33.983C71.7125 34.4703 71.8164 34.9926 71.8164 35.52C71.8164 36.0474 71.7125 36.5697 71.5107 37.057C71.3088 37.5443 71.013 37.987 70.64 38.36Z" fill="#00A86B"/>
</svg>
"""),
                  const Gap(20),
                  const Text(
                    'You are set!',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                  ),
                  SizedBox(
                    width: Get.width,
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
