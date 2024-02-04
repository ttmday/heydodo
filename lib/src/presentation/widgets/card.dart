import 'package:flutter/material.dart';
import 'package:heydodo/src/config/constants/colors.dart';
import 'package:heydodo/src/config/constants/utils.dart';

class HeyDoDoCard extends StatelessWidget {
  const HeyDoDoCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.body,
    this.footer,
    this.onPressed,
    this.actions,
    this.color,
    this.textColor,
  });

  final String title;
  final String? subtitle;
  final String body;
  final List<InlineSpan>? footer;
  final void Function()? onPressed;
  final List<Widget>? actions;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: heyDoDoPadding + 5, vertical: heyDoDoPadding),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            constraints:
                const BoxConstraints(minHeight: 110.0, maxHeight: 300.0),
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(24.0)),
            child: Stack(
              children: [
                Positioned.fill(
                    child: ColoredBox(
                  color: color ?? HeyDoDoColors.secondary,
                )),
                Positioned.fill(
                    child: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black26, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [1, .3])),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: heyDoDoPadding * 2, vertical: heyDoDoPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: constrains.maxWidth - (heyDoDoPadding + 2),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                      color: textColor ?? HeyDoDoColors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              const SizedBox(
                                width: heyDoDoPadding,
                              ),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: actions ?? [])
                            ]),
                      ),
                      const SizedBox(
                        height: heyDoDoPadding,
                      ),
                      Text(
                        subtitle ?? '',
                        style: TextStyle(
                            color: textColor ?? HeyDoDoColors.white,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: heyDoDoPadding * 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          body,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: textColor ?? HeyDoDoColors.white,
                              fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                ),
                if (footer != null && footer!.isNotEmpty)
                  Positioned(
                      bottom: heyDoDoPadding,
                      left: heyDoDoPadding * 2,
                      child: SizedBox(
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 11.0,
                                  color: textColor ?? HeyDoDoColors.white,
                                  fontWeight: FontWeight.w200),
                              children: footer),
                        ),
                      ))
              ],
            ),
          ),
        ),
      );
    });
  }
}
