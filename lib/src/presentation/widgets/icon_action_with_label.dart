import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class IconActionWithLabel extends StatelessWidget {
  const IconActionWithLabel({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.iconColor,
  });

  final void Function() onPressed;
  final IconData icon;
  final Color? iconColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.0,
            height: 35.0,
            child: Icon(
              icon,
              size: 28.0,
              color: iconColor ?? HeyDoDoColors.secondary,
            ),
          ),
          const SizedBox(
            width: heyDoDoPadding,
          ),
          Text(
            label,
            style:
                const TextStyle(color: HeyDoDoColors.secondary, fontSize: 14.0),
          )
        ],
      ),
    );
  }
}
