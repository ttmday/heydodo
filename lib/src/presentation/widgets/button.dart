import 'package:flutter/material.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class HeyDoDoButton extends StatelessWidget {
  const HeyDoDoButton(
      {required this.label,
      required this.onPressed,
      this.textColor,
      this.color,
      this.width,
      this.height,
      super.key});

  final String label;
  final void Function() onPressed;
  final Color? textColor;
  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        height: height ?? 56.0,
        padding: const EdgeInsets.symmetric(
            horizontal: heyDoDoPadding * 5, vertical: heyDoDoPadding * 2),
        decoration: BoxDecoration(
            color: color ?? HeyDoDoColors.secondary,
            borderRadius: BorderRadius.circular(24.0),
            boxShadow: [
              BoxShadow(
                  color: color != null
                      ? color!.withOpacity(.25)
                      : HeyDoDoColors.secondary.withOpacity(.25),
                  blurRadius: 4.4,
                  offset: const Offset(1.0, 3.5))
            ]),
        child: Text(
          label,
          style: TextStyle(
              color: textColor ?? HeyDoDoColors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
