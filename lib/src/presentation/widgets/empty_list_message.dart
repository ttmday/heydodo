import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class EmptyListMessage extends StatelessWidget {
  final String message;
  final String actionLabel;
  final void Function()? onPressed;
  const EmptyListMessage(
      {super.key,
      required this.message,
      required this.actionLabel,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style:
              const TextStyle(color: HeyDoDoColors.secondary, fontSize: 18.0),
        ),
        const SizedBox(
          height: heyDoDoPadding * 2,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: heyDoDoPadding * 5, vertical: heyDoDoPadding * 2),
            decoration: BoxDecoration(
                color: HeyDoDoColors.secondary,
                borderRadius: BorderRadius.circular(24.0)),
            child: Text(
              actionLabel,
              style: const TextStyle(
                  color: HeyDoDoColors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
        )
      ],
    ));
  }
}
