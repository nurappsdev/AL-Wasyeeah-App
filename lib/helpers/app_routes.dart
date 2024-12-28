




import 'package:get/get.dart';

import '../view/screen/screen.dart';

class AppRoutes {
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String registrationScreen = "/registrationScreen.dart";
  static const String forgotPassScreen = "/forgotPassScreen.dart";
  static const String otpScreen = "/otpScreen.dart";
  static const String propertyDistributionScreen = "/propertyDistributionScreen.dart";
  static const String propertyDistributionResultScreen = "/propertyDistributionResultScreen.dart";
  static const String zakatCalculatorScreen = "/zakatCalculatorScreen.dart";
  static const String profileSetting1 = "/profileSetting1.dart";
  static const String fatherInfoScreen = "/fatherInfoScreen.dart";
  static const String homeScreen = "/homeScreen.dart";
  static const String wasyyahScreen = "/wasyyahScreen.dart";
  static const String wasyyahEditScreen = "/wasyyahEditScreen.dart";
  static const String witnessesScreen = "/witnessesScreen.dart";
  static const String nomineeDetailsScreen = "/nomineeDetailsScreen.dart";

  static List<GetPage> get routes => [
   GetPage(name: splashScreen, page: () =>  SplashScreen()),
   GetPage(name: loginScreen, page: () =>  LoginScreen()),
   GetPage(name: registrationScreen, page: () =>  RegistrationScreen()),
   GetPage(name: forgotPassScreen, page: () =>  ForgotPassScreen()),
   GetPage(name: otpScreen, page: () =>  OtpVerifyScreen()),
   GetPage(name: propertyDistributionScreen, page: () => PropertyDistributionScreen()),
   GetPage(name: propertyDistributionResultScreen, page: () => PropertyDistributionResultScreen()),
   GetPage(name: zakatCalculatorScreen, page: () => ZakatCalculatorScreen()),
   GetPage(name: profileSetting1, page: () => ProfileScreen1()),
   GetPage(name: fatherInfoScreen, page: () => FatherInfoScreen()),
   GetPage(name: homeScreen, page: () => HomeScreen()),
   GetPage(name: wasyyahScreen, page: () => WasyyahScreen()),
   GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
   GetPage(name: witnessesScreen, page: () => WitnessScreen()),
   GetPage(name: nomineeDetailsScreen, page: () => NomineeDetailsScreen()),

  ];
}
