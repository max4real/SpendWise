import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/m_theme_model.dart';

Color primary = const Color(0XFFF2F2F2);
Color primaryAccent = const Color.fromARGB(255, 232, 231, 229);

// Color secondary = const Color.fromARGB(255, 116, 133, 82);
Color secondary = const Color(0XFFCAF477);

Color background = const Color(0XFF7F3DFF);
Color background2 = const Color(0XFFEEE5FF);
Color onBackground = const Color.fromARGB(255, 219, 218, 218);

Color text1 = const Color(0XFFDDDDDD);

class DarkThemData {
  static ThemeModel theme = ThemeModel(
    primary: primary,
    primaryAccent: primaryAccent,
    secondary: secondary,
    background: background,
    background2: background2,
    onBackground: onBackground,
    text1: text1,
  );
}