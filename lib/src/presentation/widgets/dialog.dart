import 'package:flutter/material.dart';

import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

enum HeyDoDoDialogAlertRole {
  confirmed,
  cancelled,
}

class HeyDoDoDialogAlert extends StatelessWidget {
  const HeyDoDoDialogAlert(
      {required this.title,
      this.titleStyle,
      required this.content,
      this.insetPadding,
      this.contentPadding,
      this.buttons,
      this.icon,
      super.key});

  final String title;
  final TextStyle? titleStyle;
  final Widget content;
  final Widget? icon;
  final EdgeInsets? insetPadding;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? buttons;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: HeyDoDoColors.white,
        surfaceTintColor: HeyDoDoColors.white,
        clipBehavior: Clip.hardEdge,
        contentPadding: contentPadding,
        insetPadding: insetPadding ?? const EdgeInsets.all(heyDoDoPadding * 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            side: BorderSide(color: HeyDoDoColors.secondary, width: 2.2)),
        icon: icon,
        title: null,
        content: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 6),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: titleStyle ??
                        const TextStyle(
                          color: HeyDoDoColors.dark,
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              if (title.isNotEmpty)
                const SizedBox(
                  height: heyDoDoPadding * 3,
                ),
              content
            ],
          ),
        ),
        actionsPadding: EdgeInsets.zero,
        actions: buttons != null
            ? [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14.0, vertical: 18.0),
                  decoration: BoxDecoration(
                      color: HeyDoDoColors.secondary.withOpacity(.15)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: buttons!,
                  ),
                )
              ]
            : []);
  }
}

class HeyDoDoDialogAlertContentText extends StatelessWidget {
  const HeyDoDoDialogAlertContentText(
      {required this.text, this.color, this.fontSize, super.key});

  final List<InlineSpan> text;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
        softWrap: true,
        textAlign: TextAlign.center,
        text: TextSpan(
            children: text,
            style: TextStyle(
                fontFamily: 'Poppins',
                color: color ?? HeyDoDoColors.medium,
                fontSize: fontSize ?? 16,
                fontWeight: FontWeight.w400,
                leadingDistribution: TextLeadingDistribution.proportional)));
  }
}

class HeyDoDoDialogAlertButton extends StatelessWidget {
  const HeyDoDoDialogAlertButton(
      {required this.label,
      required this.onPressed,
      this.color,
      this.textColor,
      this.filled = true,
      this.style,
      this.width,
      this.height,
      super.key});

  final String label;
  final void Function() onPressed;
  final Color? color;
  final Color? textColor;
  final bool? filled;
  final TextStyle? style;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Ink(
        width: width,
        height: height ?? 42.0,
        decoration: BoxDecoration(
            color:
                filled! ? color ?? HeyDoDoColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(18.0)),
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: style ??
                    TextStyle(
                      color: textColor ?? HeyDoDoColors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeyDoDoAlertButtonConfirm extends StatelessWidget {
  const HeyDoDoAlertButtonConfirm(
      {required this.label, this.onPressed, super.key});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return HeyDoDoDialogAlertButton(
        label: label,
        onPressed: onPressed ??
            () {
              Navigator.of(context).pop(HeyDoDoDialogAlertRole.confirmed);
            });
  }
}

class HeyDoDoAlertButtonCancel extends StatelessWidget {
  const HeyDoDoAlertButtonCancel(
      {required this.label, this.onPressed, super.key});

  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return HeyDoDoDialogAlertButton(
        label: label,
        textColor: HeyDoDoColors.white,
        color: HeyDoDoColors.light.withOpacity(.45),
        onPressed: onPressed ??
            () {
              Navigator.of(context).pop(HeyDoDoDialogAlertRole.cancelled);
            });
  }
}

Future<HeyDoDoDialogAlertRole?> showHeyDoDoAlert({
  required BuildContext context,
  required String title,
  TextStyle? titleStyle,
  required Widget content,
  List<Widget>? buttons,
  EdgeInsetsGeometry? contentPadding,
  Icon? icon,
}) async {
  return await showDialog<HeyDoDoDialogAlertRole>(
      context: context,
      barrierDismissible: false,
      builder: (context) => TweenAnimationBuilder(
          duration: const Duration(milliseconds: 750),
          tween: Tween(begin: 0.75, end: 1.0),
          curve: Curves.elasticOut,
          child: HeyDoDoDialogAlert(
            title: title,
            content: content,
            titleStyle: titleStyle,
            buttons: buttons ?? [],
            contentPadding: contentPadding,
            icon: icon,
          ),
          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: child,
            );
          }));
}
