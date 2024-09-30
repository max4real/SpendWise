import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(builder:(context, theme, themeController) {
      return Scaffold(
        body: Center(
          child: Text("This is SignUp"),
        ),
      );
    },);
  }
}