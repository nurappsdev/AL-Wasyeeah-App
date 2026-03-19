import 'package:al_wasyeah/helpers/dependency_injection.dart';
import 'package:al_wasyeah/view/access_control/feature_screen.dart';
import 'package:al_wasyeah/view/auth/change_password_screen.dart';
import 'package:al_wasyeah/view/auth/forgot_pass_screen.dart';
import 'package:al_wasyeah/view/auth/login_screen.dart';
import 'package:al_wasyeah/view/auth/otp_verify_screen.dart';
import 'package:al_wasyeah/view/auth/registration_screen.dart';
import 'package:al_wasyeah/view/property_distribution_calculation/property_distribution_calculation_page.dart';
import 'package:al_wasyeah/view/splash/splash_screen.dart';
import 'package:al_wasyeah/view/zakat_calculator/zakat_calculator_screen.dart';
import 'package:al_wasyeah/view/home/home_page.dart';
import 'package:al_wasyeah/view/menu/menu_page.dart';
import 'package:al_wasyeah/view/nominee/add_nominee_screen.dart';
import 'package:al_wasyeah/view/nominee/add_outside_nominee.dart';
import 'package:al_wasyeah/view/nominee/asign_nominee_details.dart';
import 'package:al_wasyeah/view/nominee/mominee_details_screen.dart';
import 'package:al_wasyeah/view/nominee/nominee_tab_screen.dart';
import 'package:al_wasyeah/view/witnessess/add_outside_witness.dart';
import 'package:al_wasyeah/view/witnessess/add_witness_screen.dart';
import 'package:al_wasyeah/view/witnessess/witness_details_screen.dart';
import 'package:al_wasyeah/view/witnessess/witness_phanel_data.dart';
import 'package:al_wasyeah/view/witnessess/witness_page.dart';
import 'package:al_wasyeah/view/notification/notification_screen.dart';
import 'package:al_wasyeah/view/onboarding/onboarding_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_edit_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_preview_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasyyah_screen.dart';
import 'package:get/get.dart';

import '../view/access_control/acceess_control_tab_screen.dart';

class AppRoutes {
  static const String splashScreen = "/";
  static const String onboardingScreen = "/onboarding_page";
  static const String loginScreen = "/login_page";
  static const String registrationScreen = "/registration_page";
  static const String forgotPassScreen = "/forget_password_page";
  static const String changePassScreen = "/change_password_page";
  static const String otpScreen = "/otp_page";
  static const String propertyDistributionScreen =
      "/property_distribution_page";

  static const String zakatCalculatorScreen = "/zakat_calculator_page";
  static const String profileSetting1 = "/profile_page";
  static const String fatherInfoScreen = "/father_info_page";
  static const String homePage = "/home_page";
  static const String wasyyahScreen = "/wasyyah_page";
  static const String wasyyahEditScreen = "/wasyyah_edit_page";
  static const String wasyyahPriviewScreen = "/wasyyah_priview_page";
  static const String witnessesPage = "/witness_page";

  static const String addWitnessesScreen = "/add_witness_page";
  static const String nomineeDetailsScreen = "/nominee_details_page";
  static const String nomineeTabScreen = "/nominee_tab_page";
  static const String witnessDetailsScreen = "/witness_details_page";
  static const String addNomineeScreen = "/add_nominee_page";
  static const String addOutsideWitnessScreen = "/add_outside_witness_page";
  static const String addOutsideNomineeScreen = "/add_outside_nominee_page";
  static const String notificationsScreen = "/notification_page";
  static const String profileInfo = "/profile_info_page";
  static const String accessControlTabScreen = "/access_control_tab_page";
  static const String featureScreen = "/feature_page";
  static const String witnessPhanelData = "/witness_phanel_data_page";
  static const String asignNomineeDetails = "/asign_nominee_details_page";

  static List<GetPage> get routes => [
        GetPage(
          name: splashScreen,
          page: () => SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(name: onboardingScreen, page: () => OnboardingScreen()),
        GetPage(name: loginScreen, page: () => LoginScreen()),
        GetPage(name: registrationScreen, page: () => RegistrationScreen()),
        GetPage(name: forgotPassScreen, page: () => ForgotPassScreen()),
        GetPage(name: changePassScreen, page: () => ChangePasswordScreen()),
        GetPage(name: otpScreen, page: () => OtpVerifyScreen()),
        GetPage(
            name: propertyDistributionScreen,
            page: () => PropertyDistributionCalculationPage(),
            binding: PropertyDistributionCalculationBinding()),
        GetPage(
          name: zakatCalculatorScreen,
          page: () => ZakatCalculatorScreen(),
          binding: ZakatCalculatorBinding(),
        ),
        GetPage(
          name: homePage,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
            name: wasyyahScreen,
            page: () => WasyyahScreen(),
            binding: WasyyahBinding()),
        GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
        GetPage(name: nomineeTabScreen, page: () => NomineeTabScreen()),
        GetPage(
            name: witnessesPage,
            page: () => WitnessesScreen(),
            binding: WitnessesBinding()),
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
