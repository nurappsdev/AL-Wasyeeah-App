import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppColors {
  // Theme-aware Getters 
  static Color get primaryColor => const Color(0xff058240);
  static Color get secondaryPrimaryColor => Get.isDarkMode ? const Color(0xff3B5446) : const Color(0xffB2D8C4);
  static Color get whiteColor => Get.isDarkMode ? const Color(0xff121212) : const Color(0xffFFFFFF);
  static Color get redColor => const Color(0xffFF0000);
  static Color get hitTextColor000000 => Get.isDarkMode ? const Color(0xFFE0E0E0) : const Color(0xCC000000);
  static Color get textColor4E4E4E => Get.isDarkMode ? const Color(0xFFB0B0B0) : const Color(0xff4E4E4E);
  static Color get cardColorBAD6EC => Get.isDarkMode ? const Color(0xff2A3D4D) : const Color(0xffBAD6EC);
  static Color get cardColorE9F2F9 => Get.isDarkMode ? const Color(0xff1E2933) : const Color(0xffE9F2F9);
  static Color get cardColorE8F1EE => Get.isDarkMode ? const Color(0xff1F2B26) : const Color(0xffE8F1EE);
  static Color get iconColor => Get.isDarkMode ? const Color.fromRGBO(255, 255, 255, 0.4) : const Color.fromRGBO(34, 34, 34, 0.4);
  static Color get grey => Get.isDarkMode ? const Color(0xff424242) : const Color(0xffC4C4C4);
}
