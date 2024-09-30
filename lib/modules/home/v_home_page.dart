import 'package:flutter/material.dart';
import 'package:spend_wise/_servies/theme_services/w_custon_theme_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaxThemeBuilder(
      builder: (context, theme, themeController) {
        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.background2,
          ),
          body: const Center(
            child: Text("Hi"),
          ),
        );
      },
    );
  }
}
