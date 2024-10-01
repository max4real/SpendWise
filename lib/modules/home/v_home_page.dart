import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.transparent,
          ),
          body: const Center(
            child: Text("This is home"),
          ),
        );
      },
    );
  }
}
