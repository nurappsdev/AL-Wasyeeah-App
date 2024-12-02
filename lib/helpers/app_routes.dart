




import 'package:get/get.dart';

import '../view/screen/screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String registrationScreen = "/registrationScreen.dart";
  static const String forgotPassScreen = "/forgotPassScreen.dart";
  static const String otpScreen = "/otpScreen.dart";

  static List<GetPage> get routes => [
   GetPage(name: splashScreen, page: () =>  SplashScreen()),
   GetPage(name: loginScreen, page: () =>  LoginScreen()),
   GetPage(name: registrationScreen, page: () =>  RegistrationScreen()),
   GetPage(name: forgotPassScreen, page: () =>  ForgotPassScreen()),
   GetPage(name: otpScreen, page: () =>  OtpVerifyScreen()),

  ];
}
