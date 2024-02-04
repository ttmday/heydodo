import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

class AddAction extends StatelessWidget {
  const AddAction({super.key, required this.onPressed});

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.0),
          color: HeyDoDoColors.primary,
        ),
        child: const Icon(
          Iconsax.add,
          size: 28.0,
          color: HeyDoDoColors.white,
        ),
      ),
    );
  }
}
