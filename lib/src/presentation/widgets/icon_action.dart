import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';

class IconAction extends StatelessWidget {
  const IconAction({
    super.key,
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });

  final void Function() onPressed;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 35.0,
        height: 35.0,
        child: Icon(
          icon,
          size: 28.0,
          color: iconColor ?? HeyDoDoColors.secondary,
        ),
      ),
    );
  }
}
