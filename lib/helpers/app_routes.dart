import 'package:al_wasyeah/view/screen/profile/profile_setup_step_three_screen.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../view/screen/access_control/acceess_control_tab_screen.dart';
import '../view/screen/screen.dart';
import '../view/screen/property_distribution_calculation/property_distribution_calculation_page.dart';
import '../view/screen/wasyyah/add_new_washyia_screen.dart';
import '../view/screen/profile/profile_page.dart';

class AppRoutes {
  static const String firstSplashScreen = "/firstSplashScreen.dart";
  static const String splashScreen = "/splashScreen.dart";
  static const String loginScreen = "/loginScreen.dart";
  static const String registrationScreen = "/registrationScreen.dart";
  static const String forgotPassScreen = "/forgotPassScreen.dart";
  static const String otpScreen = "/otpScreen.dart";
  static const String propertyDistributionScreen =
      "/propertyDistributionScreen.dart";
  static const String propertyDistributionResultScreen =
      "/propertyDistributionResultScreen.dart";
  static const String propertyDistributionCalculationScreen =
      "/propertyDistributionCalculationScreen.dart";

  static const String zakatCalculatorScreen = "/zakatCalculatorScreen.dart";
  static const String profileSetting1 = "/profileSetting1.dart";
  static const String fatherInfoScreen = "/fatherInfoScreen.dart";
  static const String homeScreen = "/homeScreen.dart";
  static const String wasyyahScreen = "/wasyyahScreen.dart";
  static const String wasyyahEditScreen = "/wasyyahEditScreen.dart";
  static const String wasyyahPriviewScreen = "/wasyyahPriviewScreen";
  static const String addNewWashyiaScreen = "/addNewWashyiaScreen.dart";
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
  static const String profilePage = "/profilePage.dart";
  static const String accessControlTabScreen = "/accessControlTabScreen.dart";
  static const String featureScreen = "/featureScreen.dart";
  static const String witnessPhanelData = "/witnessPhanelData.dart";

  static List<GetPage> get routes => [
        GetPage(name: firstSplashScreen, page: () => FirstSplashScreen()),
        GetPage(name: splashScreen, page: () => SplashScreen()),
        GetPage(
          name: loginScreen,
          page: () => LoginScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: registrationScreen,
          page: () => RegistrationScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: forgotPassScreen,
          page: () => ForgotPassScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: otpScreen,
          page: () => OtpVerifyScreen(),
          binding: AuthBinding(),
        ),
        GetPage(
            name: propertyDistributionScreen,
            page: () => PropertyDistributionScreen()),
        GetPage(
            name: propertyDistributionResultScreen,
            page: () => PropertyDistributionResultScreen()),
        GetPage(
          name: zakatCalculatorScreen,
          page: () => ZakatCalculatorScreen(),
          binding: ZakatBinding(),
        ),
        GetPage(
          name: profileSetting1,
          page: () => ProfileSettingStepOneWidget(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: fatherInfoScreen,
          page: () => ProfileSettingStepThreeWidget(),
          binding: ProfileBinding(),
        ),
        GetPage(name: homeScreen, page: () => HomeScreen()),
        GetPage(
          name: wasyyahScreen,
          page: () => WasyyahScreen(),
          binding: WasyyahBinding(),
        ),
        GetPage(
          name: wasyyahEditScreen,
          page: () => WasiyahEditScreen(),
          binding: WasyyahBinding(),
        ),
        GetPage(
          name: addNewWashyiaScreen,
          page: () => AddNewWashyiaScreen(),
          binding: WasyyahBinding(),
        ),
        GetPage(
          name: nomineeTabScreen,
          page: () => NomineeTabScreen(),
          binding: NomineeBinding(),
        ),
        GetPage(
          name: witnessesScreen,
          page: () => WitnessScreen(),
          binding: WitnessBinding(),
        ),
        GetPage(
          name: witnessTabScreen,
          page: () => WitnessTabScreen(),
          binding: WitnessBinding(),
        ),
        GetPage(
          name: addWitnessesScreen,
          page: () => AddWitnessScreen(),
          binding: WitnessBinding(),
        ),
        GetPage(
          name: nomineeDetailsScreen,
          page: () => NomineeDetailsScreen(),
          binding: NomineeBinding(),
        ),
        GetPage(
          name: witnessDetailsScreen,
          page: () => WitnessDetailsScreen(),
          binding: WitnessBinding(),
        ),
        GetPage(
          name: addNomineeScreen,
          page: () => AddNomineeScreen(),
          binding: NomineeBinding(),
        ),
        GetPage(
          name: addOutsideWitnessScreen,
          page: () => AddOutsideWitness(),
          binding: WitnessBinding(),
        ),
        GetPage(
          name: addOutsideNomineeScreen,
          page: () => AddOutsideNominee(),
          binding: NomineeBinding(),
        ),
        GetPage(name: notificationsScreen, page: () => NotificationCard()),
        GetPage(name: profileInfo, page: () => MenuPage()),
        GetPage(
          name: profilePage,
          page: () => ProfilePage(),
          binding: ProfileBinding(),
        ),
        GetPage(
          name: wasyyahPriviewScreen,
          page: () => WasyyahPreviewScreen(),
          binding: WasyyahBinding(),
        ),
        GetPage(
          name: accessControlTabScreen,
          page: () => AccessControlTabScreen(),
          binding: AccessPanelBinding(),
        ),
        GetPage(
          name: featureScreen,
          page: () => FeatureScreen(),
          binding: NomineeBinding(),
        ),
        GetPage(
          name: propertyDistributionCalculationScreen,
          page: () => PropertyDistributionCalculationPage(),
          binding: PropertyDistributionBinding(),
        ),
      ];

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
}
