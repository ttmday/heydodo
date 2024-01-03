import 'package:heydodo/src/config/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeyDoDoTheme {
  HeyDoDoTheme._();

  static ThemeData getThemeDefault() {
    return ThemeData(
        fontFamily: 'Poppins',
        primaryColor: HeyDoDoColors.secondary,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: HeyDoDoColors.white,
        ),
        scaffoldBackgroundColor: HeyDoDoColors.white,
        textTheme: const TextTheme(
            displayLarge: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 38.0,
                fontWeight: FontWeight.w600,
                color: HeyDoDoColors.white),
            displayMedium: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w500,
                color: HeyDoDoColors.white),
            displaySmall: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: HeyDoDoColors.white),
            headlineLarge: TextStyle(fontSize: 32, color: HeyDoDoColors.medium),
            headlineMedium:
                TextStyle(fontSize: 28, color: HeyDoDoColors.medium),
            headlineSmall: TextStyle(fontSize: 26, color: HeyDoDoColors.medium),
            bodyLarge: TextStyle(fontSize: 14),
            bodyMedium: TextStyle(fontSize: 13),
            bodySmall: TextStyle(fontSize: 10)),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff38a3a2))
            .copyWith(
                primary: getPrimaryColor(), background: HeyDoDoColors.white));
  }

  static setStatusBarAndNavigationBarTheme(
      {required Color color,
      required Brightness brightness,
      bool changeNavigationBrightness = true}) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: brightness,
      systemNavigationBarIconBrightness:
          changeNavigationBrightness ? brightness : null,
      statusBarColor: color, //any color of your choice
      systemNavigationBarColor: changeNavigationBrightness ? color : null,
    ));
  }

  static MaterialColor? getPrimaryColor() {
    return const MaterialColor(0xff1A120B, {
      50: Color(0xff17100a),
      100: Color(0xff150e09),
      200: Color(0xff120d08),
      300: Color(0xff100b07),
      400: Color(0xff0d0906),
      500: Color(0xff0a0704),
      600: Color(0xff080503),
      700: Color(0xff050402),
      800: Color(0xff030201),
      900: Color(0xff000000),
    });
  }
}
