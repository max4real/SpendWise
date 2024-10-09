import 'package:flutter/material.dart';

import '../../_servies/theme_services/w_custon_theme_builder.dart';

// ignore: must_be_immutable
class MaxMultiButton2 extends StatelessWidget {
  String image;
  bool value;
  bool size;
  MaxMultiButton2(
      {super.key, required this.image, required this.value, this.size = true});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Container(
          width: size ? 90 : 60,
          height: size ? 40 : 50,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: value ? const Color(0XFFEEE5FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: value ? Colors.transparent : const Color(0XFF0D0E0F),
              width: 0.1,
            ),
          ),
          child: Image.asset(image),
        );
      },
    );
  }
}
