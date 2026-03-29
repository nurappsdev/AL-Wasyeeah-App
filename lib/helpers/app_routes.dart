import 'package:al_wasyeah/helpers/dependency_injection.dart';
import 'package:al_wasyeah/view/access_control/access_control_page.dart';
import 'package:al_wasyeah/view/auth/change_password_screen.dart';
import 'package:al_wasyeah/view/auth/forgot_pass_screen.dart';
import 'package:al_wasyeah/view/auth/login_screen.dart';
import 'package:al_wasyeah/view/auth/otp_verify_screen.dart';
import 'package:al_wasyeah/view/auth/registration_screen.dart';
import 'package:al_wasyeah/view/access_control/access_control_panel_page.dart';
import 'package:al_wasyeah/view/nominee/nominee_details_page.dart';
import 'package:al_wasyeah/view/nominee/nominee_page.dart';
import 'package:al_wasyeah/view/profile/profile_page.dart';
import 'package:al_wasyeah/view/property_distribution_calculation/property_distribution_calculation_page.dart';
import 'package:al_wasyeah/view/splash/splash_screen.dart';
import 'package:al_wasyeah/view/zakat_calculator/zakat_calculator_screen.dart';
import 'package:al_wasyeah/view/home/home_page.dart';
import 'package:al_wasyeah/view/menu/menu_page.dart';
import 'package:al_wasyeah/view/witnessess/witnesses_details_page.dart';
import 'package:al_wasyeah/view/witnessess/witness_page.dart';
import 'package:al_wasyeah/view/notification/notification_screen.dart';
import 'package:al_wasyeah/view/onboarding/onboarding_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_edit_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasiyah_preview_screen.dart';
import 'package:al_wasyeah/view/wasyyah/wasyyah_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  // Splash
  static const String splashPage = "/";
  // Onboarding
  static const String onboardingPage = "/onboarding_page";
  // Auth
  static const String loginPage = "/login_page";
  static const String registrationPage = "/registration_page";
  static const String forgotPasswordPage = "/forget_password_page";
  static const String changePasswordPage = "/change_password_page";
  static const String otpPage = "/otp_page";

  // Home
  static const String homePage = "/home_page";
  static const String wasyyahScreen = "/wasyyah_page";
  static const String wasyyahEditScreen = "/wasyyah_edit_page";
  static const String wasyyahPriviewPage = "/wasyyah_priview_page";
  // Nominee
  static const String nomineesPage = "/nominee_page";
  static const String nomineeDetailsPage = "/nominee_details_page";
  // Witness
  static const String witnessesPage = "/witness_page";
  static const String witnessDetailsPage = "/witness_details_page";
  // Access Control
  static const String accessControlPage = "/access_control_page";
  static const String accessCntrolPanelPage = "/access_control_panel_page";
  // Notification
  static const String notificationPage = "/notification_page";
  // Menu
  static const String menuPage = "/menu_page";
  // Profile
  static const String profilePage = "/profile_page";
  // Feature
  static const String featureScreen = "/feature_page";
  // Property Distribution
  static const String propertyDistributionPage = "/property_distribution_page";
  // Zakat Calculation
  static const String zakatCalculatorPage = "/zakat_calculator_page";
  static List<GetPage> get routes => [
        GetPage(
          name: splashPage,
          page: () => SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(name: onboardingPage, page: () => OnboardingScreen()),
        GetPage(name: loginPage, page: () => LoginScreen()),
        GetPage(name: registrationPage, page: () => RegistrationScreen()),
        GetPage(name: forgotPasswordPage, page: () => ForgotPassScreen()),
        GetPage(name: changePasswordPage, page: () => ChangePasswordScreen()),
        GetPage(name: otpPage, page: () => OtpVerifyScreen()),
        GetPage(
          name: homePage,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(name: notificationPage, page: () => NotificationPage()),
        GetPage(
            name: wasyyahScreen,
            page: () => WasyyahScreen(),
            binding: WasyyahBinding()),
        GetPage(name: wasyyahEditScreen, page: () => WasiyahEditScreen()),
        GetPage(name: profilePage, page: () => ProfilePage()),
        GetPage(
            name: witnessesPage,
            page: () => WitnessesPage(),
            binding: WitnessesBinding()),
        GetPage(name: witnessDetailsPage, page: () => WitnessDetailsPage()),
        GetPage(
            name: nomineesPage,
            page: () => NomineesPage(),
            binding: NomineesBinding()),
        GetPage(name: nomineeDetailsPage, page: () => NomineeDetailsPage()),
        GetPage(
            name: accessControlPage,
            page: () => AccessControlPage(),
            binding: AccessControlBinding()),
        GetPage(
            name: propertyDistributionPage,
            page: () => PropertyDistributionCalculationPage(),
            binding: PropertyDistributionCalculationBinding()),
        GetPage(
          name: zakatCalculatorPage,
          page: () => ZakatCalculatorScreen(),
          binding: ZakatCalculatorBinding(),
        ),
        GetPage(name: menuPage, page: () => MenuPage()),
        GetPage(
            name: accessCntrolPanelPage,
            page: () => AccessControlPanelPage(),
            binding: AccessControlBinding()),
        GetPage(name: wasyyahPriviewPage, page: () => WasyyahPreviewPage()),
      ];
}
