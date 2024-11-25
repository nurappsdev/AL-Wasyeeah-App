




import 'package:get/get.dart';

import '../view/screen/screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String businessDetailsScreen = "/businessDetailsScreen.dart";

  static List<GetPage> get routes => [
   GetPage(name: splashScreen, page: () =>  SplashScreen()),
   GetPage(name: loginScreen, page: () =>  LoginScreen()),

  ];
}
