import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Rubik',
  primaryColor: const Color(0xFFba4f41),
  secondaryHeaderColor: const Color(0xff04B200),
  brightness: Brightness.dark,
  cardColor: const Color(0xFF252525),
  hintColor: const Color(0xFFbebebe),
  disabledColor: const Color(0xffa2a7ad),
  shadowColor: Colors.black.withValues(alpha: 0.4),
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
