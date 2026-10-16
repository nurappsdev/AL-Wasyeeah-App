import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_colors.dart';

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Rubik',
  scaffoldBackgroundColor: Colors.transparent,
  cardColor: const Color(0xFF1E1E1E),
  dialogBackgroundColor: const Color(0xFF1E1E1E),
  canvasColor: const Color(0xFF1E1E1E),
  dividerColor: const Color(0xFF2E2E2E),
  hintColor: const Color(0xFFbebebe),
  disabledColor: const Color(0xffa2a7ad),
  shadowColor: Colors.black.withValues(alpha: 0.4),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff058240),
    secondary: Color(0xffB2D8C4),
    surface: Color(0xFF1E1E1E),
    onSurface: Colors.white,
    onPrimary: Colors.white,
    outline: Color(0xFF2C3E35),
  ),
  cardTheme: CardThemeData(
    color: const Color(0xFF1E1E1E),
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Color(0xFF2C3E35)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    modalBackgroundColor: Color(0xFF1E1E1E),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.light,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: const Color(0xFF1E1E1E),
    headerBackgroundColor: const Color(0xff058240),
    headerForegroundColor: Colors.white,
    dayStyle: TextStyle(color: Colors.white, fontSize: 14.h),
    weekdayStyle: TextStyle(fontSize: 14.h, color: Colors.white70),
    yearStyle: TextStyle(fontSize: 14.h, color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Color(0xFFE0E0E0)),
    bodySmall: TextStyle(color: Color(0xFFAAAAAA)),
    titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Color(0xFFE0E0E0)),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
