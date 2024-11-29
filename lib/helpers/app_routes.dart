




import 'package:get/get.dart';

import '../view/screen/screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String registrationScreen = "/registrationScreen.dart";
  static const String forgotPassScreen = "/registrationScreen.dart";
  static const String otpScreen = "/otpScreen.dart";

  static List<GetPage> get routes => [
   GetPage(name: splashScreen, page: () =>  SplashScreen()),
   GetPage(name: loginScreen, page: () =>  LoginScreen()),
   GetPage(name: registrationScreen, page: () =>  RegistrationScreen()),
   GetPage(name: registrationScreen, page: () =>  ForgotPasswordScreen()),
   GetPage(name: otpScreen, page: () =>  OtpVerifyScreen()),

  ];
}
