import 'package:al_wasyeah/view/access_control/feature_screen.dart';
import 'package:al_wasyeah/view/auth/change_password_screen.dart';
import 'package:al_wasyeah/view/auth/forgot_pass_screen.dart';
import 'package:al_wasyeah/view/auth/login_screen.dart';
import 'package:al_wasyeah/view/auth/otp_verify_screen.dart';
import 'package:al_wasyeah/view/auth/registration_screen.dart';
=import 'package:al_wasyeah/view/before_login/property_distribution_screen.dart';
import 'package:al_wasyeah/view/before_login/zakat_calculator_screen.dart';
import 'package:al_wasyeah/view/home/home_screen.dart';
import 'package:al_wasyeah/view/menu/menu_page.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/nominee/add_nominee_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/nominee/add_outside_nominee.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/nominee/asign_nominee_details.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/nominee/mominee_details_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/nominee/nominee_tab_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/add_outside_witness.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/add_witness_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/witness_details_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/witness_phanel_data.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/witness_screen.dart';
import 'package:al_wasyeah/view/nominee_and_witness_screen/witnessess/witness_tab_screen.dart';
import 'package:al_wasyeah/view/notification/notification_screen.dart';
import 'package:al_wasyeah/view/splash/first_splash_screen.dart';
import 'package:al_wasyeah/view/splash/spalsh_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_edit_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_preview_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasyyah_screen.dart';
import 'package:get/get.dart';

import '../view/access_control/acceess_control_tab_screen.dart';

class AppRoutes {
  static const String firstSplashScreen = "/firstSplashScreen.dart";
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String registrationScreen = "/registrationScreen.dart";
  static const String forgotPassScreen = "/forgotPassScreen.dart";
  static const String changePassScreen = "/changePassScreen.dart";
  static const String otpScreen = "/otpScreen.dart";
  static const String propertyDistributionScreen =
      "/propertyDistributionScreen.dart";
  static const String propertyDistributionResultScreen =
      "/propertyDistributionResultScreen.dart";
  static const String zakatCalculatorScreen = "/zakatCalculatorScreen.dart";
  static const String profileSetting1 = "/profileSetting1.dart";
  static const String fatherInfoScreen = "/fatherInfoScreen.dart";
  static const String homeScreen = "/homeScreen.dart";
  static const String wasyyahScreen = "/wasyyahScreen.dart";
  static const String wasyyahEditScreen = "/wasyyahEditScreen.dart";
  static const String wasyyahPriviewScreen = "/wasyyahPriviewScreen";
  static const String witnessesScreen = "/witnessesScreen.dart";
  static const String witnessTabScreen = "/witnessTabScreen.dart";
  static const String addWitnessesScreen = "/addWitnessesScreen.dart";
  static const String nomineeDetailsScreen = "/nomineeDetailsScreen.dart";
  static const String nomineeTabScreen = "/nomineeTabScreen.dart";
  static const String witnessDetailsScreen = "/witnessDetailsScreen.dart";
  static const String addNomineeScreen = "/addNomineeScreen.dart";
  static const String addOutsideWitnessScreen = "/addOutsideWitnessScreen.dart";
  static const String addOutsideNomineeScreen = "/addOutsideNomineeScreen.dart";
  static const String notificationsScreen = "/notificationsScreen.dart";
  static const String profileInfo = "/profileInfo.dart";
  static const String accessControlTabScreen = "/accessControlTabScreen.dart";
  static const String featureScreen = "/featureScreen.dart";
  static const String witnessPhanelData = "/witnessPhanelData.dart";
  static const String asignNomineeDetails = "/asignNomineeDetails.dart";

  static List<GetPage> get routes => [
        //   GetPage(name: firstSplashScreen, page: () => FirstSplashScreen()),
        //   GetPage(name: splashScreen, page: () => SplashScreen()),
        //   GetPage(name: loginScreen, page: () => LoginScreen()),
        //   GetPage(name: registrationScreen, page: () => RegistrationScreen()),
        //   GetPage(name: forgotPassScreen, page: () => ForgotPassScreen()),
        //   GetPage(name: otpScreen, page: () => OtpVerifyScreen()),
        //   GetPage(
        //       name: propertyDistributionScreen,
        //       page: () => PropertyDistributionScreen()),
        //   GetPage(
        //       name: propertyDistributionResultScreen,
        //       page: () => PropertyDistributionResultScreen()),
        //   GetPage(
        //       name: zakatCalculatorScreen, page: () => ZakatCalculatorScreen()),
        //   GetPage(name: profileSetting1, page: () => ProfileSetupStepOneScreen()),
        //   GetPage(
        //       name: fatherInfoScreen, page: () => ProfileSetupStepThreeScreen()),
        //   GetPage(name: homeScreen, page: () => HomeScreen()),
        //   GetPage(name: wasyyahScreen, page: () => WasyyahScreen()),
        //   GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
        //   GetPage(name: nomineeTabScreen, page: () => NomineeTabScreen()),
        //   GetPage(name: witnessesScreen, page: () => WitnessScreen()),
        //   GetPage(name: witnessTabScreen, page: () => WitnessTabScreen()),
        //   GetPage(name: addWitnessesScreen, page: () => AddWitnessScreen()),
        //   GetPage(name: nomineeDetailsScreen, page: () => NomineeDetailsScreen()),
        //   GetPage(name: witnessDetailsScreen, page: () => WitnessDetailsScreen()),
        //   GetPage(name: addNomineeScreen, page: () => AddNomineeScreen()),
        //   GetPage(name: addOutsideWitnessScreen, page: () => AddOutsideWitness()),
        //   GetPage(name: addOutsideNomineeScreen, page: () => AddOutsideNominee()),
        //   GetPage(name: notificationsScreen, page: () => NotificationCard()),
        //   GetPage(name: profileInfo, page: () => ProfileInfo()),
        //   GetPage(name: wasyyahPriviewScreen, page: () => WasyyahPreviewScreen()),
        //   GetPage(
        //       name: accessControlTabScreen, page: () => AccessControlTabScreen()),
        //   GetPage(name: featureScreen, page: () => FeatureScreen()),
        // ];
        //  GetPage(name: firstSplashScreen, page: () =>  FirstSplashScreen()),
        //  GetPage(name: splashScreen, page: () =>  SplashScreen()),
        //  GetPage(name: loginScreen, page: () =>  LoginScreen()),
        //  GetPage(name: registrationScreen, page: () =>  RegistrationScreen()),
        //  GetPage(name: forgotPassScreen, page: () =>  ForgotPassScreen()),
        //  GetPage(name: otpScreen, page: () =>  OtpVerifyScreen()),
        //  GetPage(name: propertyDistributionScreen, page: () => PropertyDistributionScreen()),
        //  GetPage(name: propertyDistributionResultScreen, page: () => PropertyDistributionResultScreen()),
        //  GetPage(name: zakatCalculatorScreen, page: () => ZakatCalculatorScreen()),
        //  GetPage(name: profileSetting1, page: () => ProfileScreen1()),
        //  GetPage(name: fatherInfoScreen, page: () => FatherInfoScreen()),
        //  GetPage(name: homeScreen, page: () => HomeScreen()),
        //  GetPage(name: wasyyahScreen, page: () => WasyyahScreen()),
        //  GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
        //  GetPage(name: nomineeTabScreen, page: () => NomineeTabScreen()),
        //  GetPage(name: witnessesScreen, page: () => WitnessScreen()),
        //  GetPage(name: witnessTabScreen, page: () => WitnessTabScreen()),
        //  GetPage(name: addWitnessesScreen, page: () => AddWitnessScreen()),
        //  GetPage(name: nomineeDetailsScreen, page: () => NomineeDetailsScreen()),
        //  GetPage(name: witnessDetailsScreen, page: () => WitnessDetailsScreen()),
        //  GetPage(name: addNomineeScreen, page: () => AddNomineeScreen()),
        //  GetPage(name: addOutsideWitnessScreen, page: () => AddOutsideWitness()),
        //  GetPage(name: addOutsideNomineeScreen, page: () => AddOutsideNominee()),
        //  GetPage(name: notificationsScreen, page: () => NotificationCard()),
        //  GetPage(name: profileInfo, page: () => ProfileInfo()),
        //  GetPage(name: wasyyahPriviewScreen, page: () => WasyyahPreviewScreen()),
        //  GetPage(name: accessControlTabScreen, page: () => AccessControlTabScreen()),
        //  GetPage(name: featureScreen, page: () => FeatureScreen()),
        //  GetPage(name: witnessPhanelData, page: () => WitnessPhanelData()),
        //
        // ];

        GetPage(name: firstSplashScreen, page: () => FirstSplashScreen()),
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(name: loginScreen, page: () => LoginScreen()),
        GetPage(name: registrationScreen, page: () => RegistrationScreen()),
        GetPage(name: forgotPassScreen, page: () => ForgotPassScreen()),
        GetPage(name: changePassScreen, page: () => ChangePasswordScreen()),
        GetPage(name: otpScreen, page: () => OtpVerifyScreen()),
        GetPage(
            name: propertyDistributionScreen,
            page: () => PropertyDistributionScreen()),

        GetPage(
            name: zakatCalculatorScreen, page: () => ZakatCalculatorScreen()),
        // GetPage(name: profileSetting1, page: () => ProfileScreen1()),
        // GetPage(name: fatherInfoScreen, page: () => FatherInfoScreen()),
        GetPage(name: homeScreen, page: () => HomeScreen()),
        GetPage(name: wasyyahScreen, page: () => WasyyahScreen()),
        GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
        GetPage(name: nomineeTabScreen, page: () => NomineeTabScreen()),
        GetPage(name: witnessesScreen, page: () => WitnessScreen()),
        GetPage(name: witnessTabScreen, page: () => WitnessTabScreen()),
        GetPage(name: addWitnessesScreen, page: () => AddWitnessScreen()),
        GetPage(name: nomineeDetailsScreen, page: () => NomineeDetailsScreen()),
        GetPage(name: witnessDetailsScreen, page: () => WitnessDetailsScreen()),
        GetPage(name: addNomineeScreen, page: () => AddNomineeScreen()),
        GetPage(name: addOutsideWitnessScreen, page: () => AddOutsideWitness()),
        GetPage(name: addOutsideNomineeScreen, page: () => AddOutsideNominee()),
        GetPage(name: notificationsScreen, page: () => NotificationScreen()),
        GetPage(name: profileInfo, page: () => MenuPage()),
        GetPage(name: wasyyahPriviewScreen, page: () => WasyyahPreviewScreen()),
        GetPage(
            name: accessControlTabScreen, page: () => AccessControlTabScreen()),
        GetPage(name: featureScreen, page: () => FeatureScreen()),
        GetPage(name: witnessPhanelData, page: () => WitnessPhanelData()),
        GetPage(name: asignNomineeDetails, page: () => AsignNomineeDetails()),
      ];
}
