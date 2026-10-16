import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

ThemeData light = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Rubik',
  scaffoldBackgroundColor: Colors.transparent,
  cardColor: Colors.white,
  dialogBackgroundColor: Colors.white,
  canvasColor: Colors.white,
  dividerColor: const Color(0xFFE5E7EB),
  hintColor: const Color(0xFF9F9F9F),
  disabledColor: const Color(0xFFBABFC4),
  shadowColor: Colors.grey[300],
  colorScheme: const ColorScheme.light(
    primary: Color(0xff058240),
    secondary: Color(0xffB2D8C4),
    surface: Colors.white,
    onSurface: Color(0xff4E4E4E),
    onPrimary: Colors.white,
    outline: Color(0xffB0E3D3),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Color(0xffB0E3D3)),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Colors.black87),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
  ),
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    headerBackgroundColor: const Color(0xff058240),
    headerForegroundColor: Colors.white,
    dayStyle: TextStyle(color: AppColors.primaryColor, fontSize: 14.h),
    weekdayStyle: TextStyle(fontSize: 14.h, color: Colors.black),
    yearStyle: TextStyle(fontSize: 14.h, color: Colors.black),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Color(0xff1A1A1A)),
    bodyMedium: TextStyle(color: Color(0xff4E4E4E)),
    bodySmall: TextStyle(color: Color(0xff6B7280)),
    titleLarge:
        TextStyle(color: Color(0xff1A1A1A), fontWeight: FontWeight.bold),
    titleMedium: TextStyle(color: Color(0xff1A1A1A)),
    titleSmall: TextStyle(color: Color(0xff4E4E4E)),
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
);
