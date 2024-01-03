import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';

class HeyDoDoFloatingButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const HeyDoDoFloatingButton(
      {required this.child, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
      onPressed: onPressed,
      backgroundColor: HeyDoDoColors.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: SizedBox(
        child: child,
      ),
    );
  }
}
