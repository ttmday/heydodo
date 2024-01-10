import 'package:flutter/material.dart';

Route slideRightToLeftRouteAnimation(Widget child) {
  return PageRouteBuilder(
      pageBuilder: (context, ani1, ani2) => child,
      transitionsBuilder: (context, an1, ani2, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: an1,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      });
}
