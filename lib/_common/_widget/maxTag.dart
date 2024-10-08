import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../constants/app_svg.dart';

// ignore: must_be_immutable
class MaxTag extends StatelessWidget {
  String text;
  MaxTag({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
        ),
        child: Row(
          children: [
            SvgPicture.string(AppSvgs.svgGreenDot),
            const Gap(10),
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF5D5C5C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
