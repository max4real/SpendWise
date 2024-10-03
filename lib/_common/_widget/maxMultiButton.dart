import 'package:flutter/material.dart';

import '../../_servies/theme_services/w_custon_theme_builder.dart';

// ignore: must_be_immutable
class MaxMultiButton extends StatelessWidget {
  String text;
  bool value;
  MaxMultiButton({super.key, required this.text, required this.value});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Container(
          width: 90,
          height: 40,
          decoration: BoxDecoration(
            color: value ? const Color(0XFFEEE5FF) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: value ? Colors.transparent : const Color(0XFF0D0E0F),
              width: 0.1,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: value ? theme.background : const Color(0XFF0D0E0F),
              ),
            ),
          ),
        );
      },
    );
  }
}
