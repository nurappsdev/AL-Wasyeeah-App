import 'package:al_wasyeah/app/view/about_us/about_us_page.dart';
import 'package:al_wasyeah/core/services/dependency_injection.dart';
import 'package:al_wasyeah/app/view/access_control/access_control_page.dart';
import 'package:al_wasyeah/app/view/auth/change_password_screen.dart';
import 'package:al_wasyeah/app/view/auth/forgot_pass_screen.dart';
import 'package:al_wasyeah/app/view/auth/login_screen.dart';
import 'package:al_wasyeah/app/view/auth/otp_verify_screen.dart';
import 'package:al_wasyeah/app/view/auth/registration_screen.dart';
import 'package:al_wasyeah/app/view/access_control/access_control_panel_page.dart';
import 'package:al_wasyeah/app/view/contact_us/contact_us_page.dart';
import 'package:al_wasyeah/app/view/nominee/nominee_details_page.dart';
import 'package:al_wasyeah/app/view/nominee/nominee_page.dart';
import 'package:al_wasyeah/app/view/profile/profile_page.dart';
import 'package:al_wasyeah/app/view/property_distribution_calculation/property_distribution_calculation_page.dart';
import 'package:al_wasyeah/app/view/splash/splash_screen.dart';
import 'package:al_wasyeah/app/view/zakat_calculator/zakat_calculator_screen.dart';
import 'package:al_wasyeah/app/view/home/home_page.dart';
import 'package:al_wasyeah/app/view/menu/menu_page.dart';
import 'package:al_wasyeah/app/view/witnessess/witnesses_details_page.dart';
import 'package:al_wasyeah/app/view/witnessess/witness_page.dart';
import 'package:al_wasyeah/app/view/notification/notification_screen.dart';
import 'package:al_wasyeah/app/view/onboarding/onboarding_screen.dart';
import 'package:al_wasyeah/app/view/wasyyah/wasyyah_page.dart';
import 'package:al_wasyeah/app/view/wasyyah/wasyyah_pdf_preview_page.dart';
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
  // Wasyyah
  static const String wasyyahPage = "/wasyyah_page";
  static const String wasyyahPdfPreviewPage = "/wasyyah_pdf_preview_page";
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
  // Contact
  static const String contactPage = "/contact_page";
  static const String aboutPage = "/about_page";

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
        GetPage(name: wasyyahPage, page: () => WasyyahPage(), binding: WasyyahBinding()),
        GetPage(name: wasyyahPdfPreviewPage, page: () => const WasyyahPdfPreviewPage()),
        GetPage(name: profilePage, page: () => ProfilePage()),
        GetPage(name: witnessesPage, page: () => WitnessesPage(), binding: WitnessesBinding()),
        GetPage(name: witnessDetailsPage, page: () => WitnessDetailsPage()),
        GetPage(name: nomineesPage, page: () => NomineesPage(), binding: NomineesBinding()),
        GetPage(name: nomineeDetailsPage, page: () => NomineeDetailsPage()),
        GetPage(name: accessControlPage, page: () => AccessControlPage(), binding: AccessControlBinding()),
        GetPage(name: propertyDistributionPage, page: () => PropertyDistributionCalculationPage(), binding: PropertyDistributionCalculationBinding()),
        GetPage(
          name: zakatCalculatorPage,
          page: () => ZakatCalculatorScreen(),
          binding: ZakatCalculatorBinding(),
        ),
        GetPage(name: menuPage, page: () => MenuPage()),
        GetPage(name: accessCntrolPanelPage, page: () => AccessControlPanelPage(), binding: AccessControlBinding()),
        GetPage(name: contactPage, page: () => ContactUsPage(), binding: ContactBinding()),
        GetPage(name: aboutPage, page: () => AboutUsPage()),
      ];
}
