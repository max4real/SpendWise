import 'dart:math';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';

class Testtt extends StatelessWidget {
  const Testtt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedToggleSwitch<int>.size(
        // current: min(value, 2),
        current: min(0, 2),
        style: ToggleStyle(
          backgroundColor: const Color(0xFF919191),
          indicatorColor: const Color(0xFFEC3345),
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
          indicatorBorderRadius: BorderRadius.zero,
        ),
        values: const [0, 1, 2],
        iconOpacity: 1.0,
        selectedIconScale: 1.0,
        indicatorSize: const Size.fromWidth(100),
        iconAnimationType: AnimationType.onHover,
        styleAnimationType: AnimationType.onHover,
        spacing: 2.0,
        customSeparatorBuilder: (context, local, global) {
          final opacity =
              ((global.position - local.position).abs() - 0.5).clamp(0.0, 1.0);
          return VerticalDivider(
              indent: 10.0,
              endIndent: 10.0,
              color: Colors.white38.withOpacity(opacity));
        },
        customIconBuilder: (context, local, global) {
          final text = const ['not', 'only', 'icons'][local.index];
          return Center(
              child: Text(text,
                  style: TextStyle(
                      color: Color.lerp(
                          Colors.black, Colors.white, local.animationValue))));
        },
        borderWidth: 0.0,
        // onChanged: (i) => setState(() => value = i),
      ),
    );
  }
}
