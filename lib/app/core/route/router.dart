import 'package:wasiyyat/app/core/route/route_names.dart';
import 'package:wasiyyat/app/view/about_us/about_us_page.dart';
import 'package:wasiyyat/app/core/di/dependency_injection.dart';
import 'package:wasiyyat/app/view/access_control/access_control_page.dart';
import 'package:wasiyyat/app/view/auth/change_password_page.dart';
import 'package:wasiyyat/app/view/auth/forgot_pass_page.dart';
import 'package:wasiyyat/app/view/auth/login_page.dart';
import 'package:wasiyyat/app/view/auth/otp_verify_page.dart';
import 'package:wasiyyat/app/view/auth/registration_page.dart';
import 'package:wasiyyat/app/view/access_control/access_control_panel_page.dart';
import 'package:wasiyyat/app/view/contact_us/contact_us_page.dart';
import 'package:wasiyyat/app/view/nominee/nominee_details_page.dart';
import 'package:wasiyyat/app/view/nominee/nominee_page.dart';
import 'package:wasiyyat/app/view/profile/profile_page.dart';
import 'package:wasiyyat/app/view/property_distribution_calculation/property_distribution_calculation_page.dart';
import 'package:wasiyyat/app/view/splash/splash_screen.dart';
import 'package:wasiyyat/app/view/zakat_calculator/zakat_calculator_screen.dart';
import 'package:wasiyyat/app/view/home/home_page.dart';
import 'package:wasiyyat/app/view/menu/menu_page.dart';
import 'package:wasiyyat/app/view/witnessess/witnesses_details_page.dart';
import 'package:wasiyyat/app/view/witnessess/witness_page.dart';
import 'package:wasiyyat/app/view/notification/notification_page.dart';
import 'package:wasiyyat/app/view/onboarding/onboarding_screen.dart';
import 'package:wasiyyat/app/view/wasiyyah/wasyyah_page.dart';
import 'package:wasiyyat/app/view/wasiyyah/wasyyah_pdf_preview_page.dart';
import 'package:get/get.dart';

class AppRouter {
  static List<GetPage> get routes => [
        GetPage(
          name: RouteName.splashPage,
          page: () => SplashScreen(),
          binding: SplashBinding(),
        ),
        GetPage(name: RouteName.onboardingPage, page: () => OnboardingScreen()),
        GetPage(name: RouteName.loginPage, page: () => LoginPage()),
        GetPage(
            name: RouteName.registrationPage, page: () => RegistrationPage()),
        GetPage(
            name: RouteName.forgotPasswordPage,
            page: () => ForgotPasswordPage()),
        GetPage(
            name: RouteName.changePasswordPage,
            page: () => ChangePasswordPage()),
        GetPage(name: RouteName.otpPage, page: () => OtpVerifyPage()),
        GetPage(
          name: RouteName.homePage,
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
        GetPage(
            name: RouteName.notificationPage, page: () => NotificationPage()),
        GetPage(
            name: RouteName.wasyyahPage,
            page: () => WasyyahPage(),
            binding: WasyyahBinding()),
        GetPage(
            name: RouteName.wasyyahPdfPreviewPage,
            page: () => const WasyyahPdfPreviewPage()),
        GetPage(name: RouteName.profilePage, page: () => ProfilePage()),
        GetPage(
            name: RouteName.witnessesPage,
            page: () => WitnessesPage(),
            binding: WitnessesBinding()),
        GetPage(
            name: RouteName.witnessDetailsPage,
            page: () => WitnessDetailsPage()),
        GetPage(
            name: RouteName.nomineesPage,
            page: () => NomineesPage(),
            binding: NomineesBinding()),
        GetPage(
            name: RouteName.nomineeDetailsPage,
            page: () => NomineeDetailsPage()),
        GetPage(
            name: RouteName.accessControlPage,
            page: () => AccessControlPage(),
            binding: AccessControlBinding()),
        GetPage(
            name: RouteName.propertyDistributionPage,
            page: () => PropertyDistributionCalculationPage(),
            binding: PropertyDistributionCalculationBinding()),
        GetPage(
          name: RouteName.zakatCalculatorPage,
          page: () => ZakatCalculatorScreen(),
          binding: ZakatCalculatorBinding(),
        ),
        GetPage(name: RouteName.menuPage, page: () => MenuPage()),
        GetPage(
            name: RouteName.accessCntrolPanelPage,
            page: () => AccessControlPanelPage(),
            binding: AccessControlBinding()),
        GetPage(
            name: RouteName.contactPage,
            page: () => ContactUsPage(),
            binding: ContactBinding()),
        GetPage(name: RouteName.aboutPage, page: () => AboutUsPage()),
      ];
}
