import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

ThemeData light() => ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: const Color(0xFFFC6A57),
    secondaryHeaderColor: const Color(0xff04B200),
    brightness: Brightness.light,
    cardColor: Colors.white,
    hintColor: const Color(0xFF9F9F9F),
    disabledColor: const Color(0xFFBABFC4),
    shadowColor: Colors.grey[300],
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.black.withOpacity(0.12),
    ),
    datePickerTheme: DatePickerThemeData(
      dayStyle: TextStyle(color: AppColors.primaryColor, fontSize: 14.h),
      weekdayStyle: TextStyle(fontSize: 14.h, color: Colors.black),
    ));
