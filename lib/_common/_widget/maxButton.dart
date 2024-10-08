import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

// ignore: must_be_immutable
class MaxButton extends StatelessWidget {
  String title;
  MaxButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 110),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      },
    );
  }
}
