import 'package:flutter/material.dart';
import 'extensions.dart';

class AppColors {
  // Theme-aware Getters
  static Color get primaryColor => const Color(0xff058240);
  static Color get secondaryPrimaryColor => const Color(0xffB2D8C4);
  static Color get whiteColor => const Color(0xffFFFFFF);
  static Color get blackColor => isDarkMode() ? const Color(0xffFFFFFF) : const Color(0xff000000);
  static Color get redColor => const Color(0xffFF0000);
  static Color get hitTextColor000000 => isDarkMode() ? const Color(0xCCFFFFFF) : const Color(0xCC000000);
  static Color get textColor4E4E4E => isDarkMode() ? const Color(0xffE2E8F0) : const Color(0xff4E4E4E);
  static Color get cardColorBAD6EC => isDarkMode() ? const Color(0xff1C2E3D) : const Color(0xffBAD6EC);
  static Color get cardColorE9F2F9 => isDarkMode() ? const Color(0xff1A2630) : const Color(0xffE9F2F9);
  static Color get cardColorE8F1EE => isDarkMode() ? const Color(0xff1B2E26) : const Color(0xffE8F1EE);
  static Color get iconColor => isDarkMode() ? const Color.fromRGBO(235, 235, 235, 0.7) : const Color.fromRGBO(34, 34, 34, 0.4);
  static Color get grey => isDarkMode() ? const Color(0xff64748B) : const Color(0xffC4C4C4);

  // Semantic Theme Colors
  static Color get cardColor => isDarkMode() ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
  static Color get cardBorderColor => isDarkMode() ? const Color(0xFF2C3E35) : const Color(0xffB0E3D3);
  static Color get inputFillColor => isDarkMode() ? const Color(0xFF25282B) : const Color(0xFFFFFFFF);
  static Color get inputBorderColor => isDarkMode() ? const Color(0xFF384046) : const Color(0xffB0E3D3);
  static Color get textPrimary => isDarkMode() ? Colors.white : const Color(0xff1A1A1A);
  static Color get textSecondary => isDarkMode() ? const Color(0xffA0AEC0) : const Color(0xff6B7280);
}

